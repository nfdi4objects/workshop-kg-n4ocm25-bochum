library(tidyverse)
library(httr2)
library(FactoMineR)
library(factoextra)

endpoint <- "https://graph.nfdi4objects.net/api/sparql"

querySamian <- "
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX lado: <http://archaeology.link/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX amt: <http://academic-meta-tool.xyz/vocab#>
PREFIX samian: <http://data.archaeology.link/data/samian/>

SELECT ?Find ?Type ?GenericPotform ?DiscPlace ?ProdSite ?ProdRegion ?ActorID ?ActorName
FROM <https://graph.nfdi4objects.net/collection/8> WHERE {
?ProdSiteID rdf:type lado:ProductionCentre;
	rdfs:label ?ProdSite;
	lado:clusteredAs ?ProdRegionID;
	lado:isKilnsiteOf ?Find.
?ProdRegionID rdf:type lado:KilnRegion;
	rdfs:label ?ProdRegion.
?Find rdf:type lado:InformationCarrier;
	lado:representedBy ?TypeID;
	lado:disclosedAt ?DiscPlaceID;
 	lado:carries ?InscriptionID.
  OPTIONAL {?InscriptionID lado:isAbout ?ActorID.}
  OPTIONAL {?ActorID lado:name ?ActorName.}
  OPTIONAL {?ActorID lado:hasEntity ?ActorEntityID;
  	lado:hasStatus lado:ChiefPotter.}
?DiscPlaceID rdfs:label ?DiscPlace.
?TypeID amt:instanceOf lado:Potform;
	rdfs:label ?Type;
	lado:generalisedAs ?GenericPotformID.
?GenericPotformID rdfs:label ?GenericPotform.
} ORDER BY ?Find
"

# Send query via GET with URL-encoding
resSamian <- request(endpoint) %>%
  req_url_query(query = querySamian) %>%
  req_headers("Accept" = "application/sparql-results+json") %>%
  req_perform()

# Parse JSON directly
rawSamian <- resSamian %>% resp_body_json()

# Flatten into tibble (generic parser)
bindingsSamian <- rawSamian$results$bindings
Samian <- map_dfr(bindingsSamian, function(row) {
  tibble(!!!setNames(lapply(row, function(v) v$value), names(row)))
})

print(Samian)