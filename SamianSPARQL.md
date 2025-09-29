# N4O KG SPARQL Queries

## general query for potforms, discovery site, kiln site and kiln region

```sparql
PREFIX geosparql: <http://www.opengis.net/ont/geosparql#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX lado: <http://archaeology.link/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX amt: <http://academic-meta-tool.xyz/vocab#>
PREFIX samian: <http://data.archaeology.link/data/samian/>

SELECT ?findID ?genericpotformLabel ?discoverysiteLabel ?discoverysiteGeom ?kilnsiteLabel ?kilnsiteGeom ?kilnsiteDOC ?kilnregionLabel
FROM <https://graph.nfdi4objects.net/collection/8> WHERE {
  ?findID rdf:type lado:InformationCarrier.
  ?findID lado:representedBy ?potformID.
  ?potformID lado:generalisedAs ?genericpotformID.
  ?genericpotformID rdfs:label ?genericpotformLabel.
  ?findID lado:disclosedAt ?discoverysiteID.
  ?discoverysiteID rdfs:label ?discoverysiteLabel.
  ?discoverysiteID geosparql:hasGeometry ?discoverysiteGeometry.
  ?discoverysiteGeometry geosparql:asWKT ?discoverysiteGeom.
  ?findID lado:hasKilnsite ?kilnsiteID.
  ?kilnsiteID rdfs:label ?kilnsiteLabel.
  ?kilnsiteID geosparql:hasGeometry ?kilnsiteGeometry.
  ?kilnsiteGeometry geosparql:asWKT ?kilnsiteGeom.
  ?findID lado:hasAMT ?kilnsiteAMT.
  ?kilnsiteAMT rdf:object ?kilnsiteID.
  ?kilnsiteAMT amt:weight ?kilnsiteDOC.
  ?kilnsiteID lado:clusteredAs ?kilnregionID.
  ?kilnregionID rdfs:label ?kilnregionLabel.
} ORDER BY ?findID
LIMIT 100
```

## subquery for kilns

```sparql
PREFIX geosparql: <http://www.opengis.net/ont/geosparql#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX lado: <http://archaeology.link/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX amt: <http://academic-meta-tool.xyz/vocab#>
PREFIX samian: <http://data.archaeology.link/data/samian/>

SELECT ?item ?genericpotformLabel ?kilnsiteLabel ?geo ?kilnsiteDOC ?kilnregionLabel
FROM <https://graph.nfdi4objects.net/collection/8> WHERE {
  ?item rdf:type lado:InformationCarrier.
  ?item lado:representedBy ?potformID.
  ?potformID lado:generalisedAs ?genericpotformID.
  ?genericpotformID rdfs:label ?genericpotformLabel.
  ?item lado:hasKilnsite ?kilnsiteID.
  ?kilnsiteID rdfs:label ?kilnsiteLabel.
  ?kilnsiteID geosparql:hasGeometry ?kilnsiteGeometry.
  ?kilnsiteGeometry geosparql:asWKT ?geo.
  ?item lado:hasAMT ?kilnsiteAMT.
  ?kilnsiteAMT rdf:object ?kilnsiteID.
  ?kilnsiteAMT amt:weight ?kilnsiteDOC.
  ?kilnsiteID lado:clusteredAs ?kilnregionID.
  ?kilnregionID rdfs:label ?kilnregionLabel.
} ORDER BY ?item
LIMIT 1000
```

## subquery for discovery sites

```sparql
PREFIX geosparql: <http://www.opengis.net/ont/geosparql#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX lado: <http://archaeology.link/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX amt: <http://academic-meta-tool.xyz/vocab#>
PREFIX samian: <http://data.archaeology.link/data/samian/>

SELECT ?item ?genericpotformLabel ?discoverysiteLabel ?geo
FROM <https://graph.nfdi4objects.net/collection/8> WHERE {
  ?item rdf:type lado:InformationCarrier.
  ?item lado:representedBy ?potformID.
  ?potformID lado:generalisedAs ?genericpotformID.
  ?genericpotformID rdfs:label ?genericpotformLabel.
  ?item lado:disclosedAt ?discoverysiteID.
  ?discoverysiteID rdfs:label ?discoverysiteLabel.
  ?discoverysiteID geosparql:hasGeometry ?discoverysiteGeometry.
  ?discoverysiteGeometry geosparql:asWKT ?geo.
} ORDER BY ?item
LIMIT 1000
```

## subquery: number of sherds by generic potform found in X

```sparql
PREFIX geosparql: <http://www.opengis.net/ont/geosparql#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX lado: <http://archaeology.link/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX amt: <http://academic-meta-tool.xyz/vocab#>
PREFIX samian: <http://data.archaeology.link/data/samian/>

SELECT ?genericpotformLabel ?item ?geo (count(distinct ?findID) as ?count)
FROM <https://graph.nfdi4objects.net/collection/8> WHERE {
  ?findID rdf:type lado:InformationCarrier.
  ?findID lado:representedBy ?potformID.
  ?potformID lado:generalisedAs ?genericpotformID.
  ?genericpotformID rdfs:label ?genericpotformLabel.
  ?findID lado:disclosedAt ?discoverysiteID.
  ?discoverysiteID rdfs:label ?item.
  ?discoverysiteID geosparql:hasGeometry ?discoverysiteGeometry.
  ?discoverysiteGeometry geosparql:asWKT ?geo.
} GROUP BY ?genericpotformLabel ?item ?geo ORDER BY ?item DESC(?count)
LIMIT 10000
```

## subquery: number of sherds by generic potform produced in X

PREFIX geosparql: <http://www.opengis.net/ont/geosparql#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX lado: <http://archaeology.link/ontology#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX amt: <http://academic-meta-tool.xyz/vocab#>
PREFIX samian: <http://data.archaeology.link/data/samian/>

SELECT ?genericpotformLabel ?item ?geo (count(distinct ?findID) as ?count) ?kilnsiteDOC
FROM <https://graph.nfdi4objects.net/collection/8> WHERE {
  ?findID rdf:type lado:InformationCarrier.
  ?findID lado:representedBy ?potformID.
  ?potformID lado:generalisedAs ?genericpotformID.
  ?genericpotformID rdfs:label ?genericpotformLabel.
  ?findID lado:hasKilnsite ?kilnsiteID.
  ?kilnsiteID rdfs:label ?item.
  ?kilnsiteID geosparql:hasGeometry ?kilnsiteGeometry.
  ?kilnsiteGeometry geosparql:asWKT ?geo.
  ?findID lado:hasAMT ?kilnsiteAMT.
  ?kilnsiteAMT rdf:object ?kilnsiteID.
  ?kilnsiteAMT amt:weight ?kilnsiteDOC.
  
} GROUP BY ?genericpotformLabel ?item ?geo ?kilnsiteDOC ORDER BY ?item DESC(?count)
LIMIT 1000
