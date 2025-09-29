# N4O KG SPARQL Queries

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
