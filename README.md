# skilda [![Build Status](https://secure.travis-ci.org/sschmeck/skilda.png?branch=master)](http://travis-ci.org/sschmeck/skilda) [![Coverage Status](https://coveralls.io/repos/sschmeck/skilda/badge.png?branch=master)](https://coveralls.io/r/sschmeck/skilda?branch=master) [![Code Climate](https://codeclimate.com/github/sschmeck/skilda.png)](https://codeclimate.com/github/sschmeck/skilda)
See [demo application](http://skilda.heroku.com).

## Getting started

* requires Ruby >= 1.9, bundler
* pdfkit gem needs wkhtmltopdf (`sudo apt-get install wkhtmltopdf`)
```
bundle install       # installs dependencies
rake neo4j:install   # installs neo4j server (community, 2.0.1)
rake neo4j:start     # starts the neo4j server, ensure JAVA_HOME is set to Java >= 7
                     # => http://localhost:7474
rake neo4j:seed      # create seed data
ruby app/server.rb   # => http://localhost:4567

rake neo4j:stop      # stops the neo4j server
```
