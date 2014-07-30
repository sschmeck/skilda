# skilda [![Build Status](https://secure.travis-ci.org/sschmeck/skilda.png?branch=master)](http://travis-ci.org/sschmeck/skilda) [![Coverage Status](https://coveralls.io/repos/sschmeck/skilda/badge.png?branch=master)](https://coveralls.io/r/sschmeck/skilda?branch=master) [![Code Climate](https://codeclimate.com/github/sschmeck/skilda.png)](https://codeclimate.com/github/sschmeck/skilda) [![PullReview stats](https://www.pullreview.com/github/sschmeck/skilda/badges/master.svg?)](https://www.pullreview.com/github/sschmeck/skilda/reviews/master)
See [demo application](http://skilda.heroku.com).

## Getting started

* requires Ruby >= 1.9 with bundler gem
* pdfkit gem needs [wkhtmltopdf](http://wkhtmltopdf.org/) (e.g. `sudo apt-get install wkhtmltopdf`)
* neo4j database needs Java >= 7, `JAVA_HOME` must be set 
```
bundle install       # installs dependencies
rake neo4j:install   # installs neo4j server (community, 2.0.1)
rake neo4j:start     # => http://localhost:7474
rake neo4j:seed      # create seed data
ruby app/server.rb   # => http://localhost:4567

rake neo4j:stop      # stops the neo4j server
```
