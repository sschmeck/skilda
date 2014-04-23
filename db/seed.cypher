// execute with '$ neo4j-shell -file seed.cypher'
MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r;

CREATE
  (p1:Person {firstname:"Matthias",lastname:"Baumgart"}),
  (p2:Person {firstname:"Marco",lastname:"Dierenfeldt"}),
  (p3:Person {firstname:"Sebastian",lastname:"Schmeck"});

CREATE
  (s1:Skill {name:"Java",category:"Programmiersprache",synonyms:["Java 5","Java 6","JEE"],description:"Eine statisch typisierte Sprache."}),
  (s2:Skill {name:"JavaScript",category:"Programmiersprache",synonyms:["JS"],description:"Eine dynamisch typisierte Sprache."}),
  (s3:Skill {name:"Ruby",category:"Programmiersprache",synonyms:["JRuby"],description:"Eine dynamisch typisierte Skriptsprache."}),
  (s4:Skill {name:"Neo4j",category:"Datenbank",synonyms:[],description:"Eine Graph-Datenbank."}),
  (s5:Skill {name:"Lua",category:"Programmiersprache",synonyms:[],description:"Eine dynamisch typisierte Skriptsprache."});


MATCH (e:Person {lastname:"Schmeck"}), (s:Skill {name:"Ruby"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Professionell"}]->(s);
MATCH (e:Person {lastname:"Schmeck"}), (s:Skill {name:"Java"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Professionell"}]->(s);
MATCH (e:Person {lastname:"Schmeck"}), (s:Skill {name:"JavaScript"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Grundlagen"}]->(s);
MATCH (e:Person {lastname:"Schmeck"}), (s:Skill {name:"Neo4j"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Grundlagen"}]->(s);

MATCH (e:Person {lastname:"Baumgart"}), (s:Skill {name:"Ruby"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Grundlagen"}]->(s);
MATCH (e:Person {lastname:"Baumgart"}), (s:Skill {name:"Java"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Professionell"}]->(s);
MATCH (e:Person {lastname:"Baumgart"}), (s:Skill {name:"Neo4j"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Fortgeschritten"}]->(s);
MATCH (p:Person {lastname:"Baumgart"}), (s:Skill {name:"Ruby"})
CREATE UNIQUE (p)-[r:HAS_SKILL {level:"Grundlagen"}]->(s);

MATCH (e:Person {lastname:"Dierenfeldt"}), (s:Skill {name:"Java"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Professionell"}]->(s);
MATCH (e:Person {lastname:"Dierenfeldt"}), (s:Skill {name:"JavaScript"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Professionell"}]->(s);
MATCH (e:Person {lastname:"Dierenfeldt"}), (s:Skill {name:"Neo4j"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Grundlagen"}]->(s);
MATCH (e:Person {lastname:"Dierenfeldt"}), (s:Skill {name:"Lua"})
CREATE UNIQUE (e)-[r:HAS_SKILL {level:"Professionell"}]->(s);