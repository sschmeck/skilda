// execute with '$ neo4j-shell -file seed.cypher'
MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r;

CREATE
  (p1:Person {firstname:"Matthias",lastname:"Baumgart"}),
  (p2:Person {firstname:"Marco",lastname:"Dierenfeldt"}),
  (p3:Person {firstname:"Sebastian",lastname:"Schmeck"});

// Create SkillCategories
CREATE CONSTRAINT ON (c:SkillCategory) ASSERT c.name IS UNIQUE;
MERGE (c:SkillCategory {name: "Branchenkenntnis"});
MERGE (c:SkillCategory {name: "Betriebssystem"});
MERGE (c:SkillCategory {name: "Programmiersprache"});
MERGE (c:SkillCategory {name: "Framework"});
MERGE (c:SkillCategory {name: "API"});
MERGE (c:SkillCategory {name: "Datenbank"});
MERGE (c:SkillCategory {name: "Server"});
MERGE (c:SkillCategory {name: "Vorgehensmodell"});
MERGE (c:SkillCategory {name: "Entwurfsmethode"});
MERGE (c:SkillCategory {name: "Seitenbeschreibungssprache"});
MERGE (c:SkillCategory {name: "Standard"});
MERGE (c:SkillCategory {name: "Werkzeuge"});
MERGE (c:SkillCategory {name: "Sprache"});
MERGE (c:SkillCategory {name: "Versionsverwaltung"});

// Create Skills
CREATE CONSTRAINT ON (s:Skill) ASSERT s.name IS UNIQUE;
MERGE (s1:Skill {name:"Java", synonyms:["Java 5","Java 6","JEE"],description:"Eine statisch typisierte Sprache."});
MATCH (c:SkillCategory {name: "Programmiersprache"}), (s:Skill {name: "Java"}) MERGE (s)-[:IS_A]->(c);
MERGE (s2:Skill {name:"JavaScript" ,synonyms:["JS"],description:"Eine dynamisch typisierte Sprache."});
MATCH (c:SkillCategory {name: "Programmiersprache"}), (s:Skill {name: "JavaScript"}) MERGE (s)-[:IS_A]->(c);
MERGE (s3:Skill {name:"Ruby", synonyms:["JRuby"],description:"Eine dynamisch typisierte Skriptsprache."});
MATCH (c:SkillCategory {name: "Programmiersprache"}), (s:Skill {name: "Ruby"}) MERGE (s)-[:IS_A]->(c);
MERGE (s5:Skill {name:"Lua", synonyms:[],description:"Eine dynamisch typisierte Skriptsprache."});
MATCH (c:SkillCategory {name: "Programmiersprache"}), (s:Skill {name: "Lua"}) MERGE (s)-[:IS_A]->(c);
MERGE (s4:Skill {name:"Neo4j", synonyms:[],description:"Eine Graph-Datenbank."});
MATCH (c:SkillCategory {name: "Datenbank"}), (s:Skill {name: "Neo4j"}) MERGE (s)-[:IS_A]->(c);



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

MERGE (pr:Project {abvr: "EVCOP", title: "Ein voll cooles Projekt", description: "Ein voll cooles Softwareprojekt."});
MERGE (pr:Project {abvr: "skilda", title: "skilda: Skillprofile auf einem neuen Level.", description: "Mit skilda können Skillprofile erstellt, gesucht, gefunden und als PDF exportiert werden."});

MATCH (pr:Project {abvr: "EVCOP"}), (p:Person {lastname:"Schmeck"})
MERGE (p)-[:WORKED_FOR {from: "01.06.2013", to: "31.12.2013", as:["Softwareentwickler"]}]->(pr);

MATCH (pr:Project {abvr: "EVCOP"}), (p:Person {lastname:"Dierenfeldt"})
MERGE (p)-[:WORKED_FOR {from: "01.06.2013", to: "31.12.2013", as:["Softwareentwickler"]}]->(pr);

MATCH (pr:Project {abvr: "skilda"}), (p:Person {lastname:"Schmeck"})
MERGE (p)-[:WORKED_FOR {from: "01.01.2014", as:["Softwareentwickler"]}]->(pr);

MATCH (pr:Project {abvr: "skilda"}), (p:Person {lastname:"Baumgart"})
MERGE (p)-[:WORKED_FOR {from: "01.01.2014", as:["Softwareentwickler"]}]->(pr);

