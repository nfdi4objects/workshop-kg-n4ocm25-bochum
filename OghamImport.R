library(tidyverse)
library(httr2)
library(dplyr)
library(purrr)
library(FactoMineR)
library(factoextra)

endpoint <- "https://graph.nfdi4objects.net/api/sparql"

queryOgham <- "
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX ogham: <http://lod.ogham.link/data/>
PREFIX oghamonto: <http://ontology.ogham.link/>
PREFIX geosparql: <http://www.opengis.net/ont/geosparql#>
PREFIX sf: <http://www.opengis.net/ont/sf#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX prov: <http://www.w3.org/ns/prov#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>

SELECT ?Find ?Completeness ?Form ?Height ?Width ?Thickness ?Site
       (SAMPLE(?LocationTypeID) AS ?SiteType) ?County ?Province ?Country
FROM <https://graph.nfdi4objects.net/collection/9>
WHERE {
  ?ActivityID rdf:type prov:Activity .
  ?LocationID prov:wasGeneratedBy ?ActivityID .
  OPTIONAL { ?LocationID oghamonto:sitetype ?LocationTypeID . }
  ?SiteID rdf:type oghamonto:OghamSite ;
          oghamonto:hasLocation ?LocationID ;
          rdfs:label ?Site ;
          oghamonto:label_county ?County ;
          oghamonto:label_province ?Province ;
          oghamonto:label_country ?Country ;
          geosparql:hasGeometry ?GeometryID .
  ?Find oghamonto:disclosedAt ?SiteID .
  OPTIONAL { ?Find oghamonto:form ?Form . }
  OPTIONAL { ?Find oghamonto:completeness ?Completeness . }
  OPTIONAL { ?Find oghamonto:width ?Width . }
  OPTIONAL { ?Find oghamonto:height ?Height . }
  OPTIONAL { ?Find oghamonto:thickness ?Thickness . }
}
GROUP BY ?Find ?Completeness ?Form ?Height ?Width ?Thickness ?Site ?County ?Province ?Country
"

# Send query via GET with URL-encoding
resOgham <- request(endpoint) %>%
  req_url_query(query = queryOgham) %>%
  req_headers("Accept" = "application/sparql-results+json") %>%
  req_perform()

# Parse JSON directly
rawOgham <- resOgham %>% resp_body_json()

# Flatten into tibble (generic parser)
bindingsOgham <- rawOgham$results$bindings
Ogham <- map_dfr(bindingsOgham, function(row) {
  tibble(!!!setNames(lapply(row, function(v) v$value), names(row)))
})

Ogham$Height <- as.numeric(Ogham$Height)
Ogham$Width <- as.numeric(Ogham$Width)
Ogham$Thickness <- as.numeric(Ogham$Thickness)
print(Ogham)