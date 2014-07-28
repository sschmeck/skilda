// execute with '$ neo4j-shell -file seed.cypher'
MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r;
