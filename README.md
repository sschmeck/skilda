# skilda


## Getting started

* requires Ruby >= 1.9, bundler

```
bundle install       # installs dependencies
rake neo4j:install   # installs neo4j server (community, 2.0.1)
rake start           # starts the neo4j server, ensure JAVA_HOME is set to Java >= 7
                         # => http://localhost:7474
ruby app/server.rb   # => http://localhost:4567
```