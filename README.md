## Dependencies
* Using Ruby 2.2.1
* Tested on Mac OS X

## how to start server (requires mongodb)
rails s # -p $PORT

## how to run tests (requires mongodb)
* `rspec -f d spec/controllers spec/models`

## endpoints to hit

* `GET http://localhost:3000/api/birds`
* `POST http://localhost:3000/api/birds`
* `GET http://localhost:3000/api/birds/57692020c5231b94f8d78b36`
* `DELETE http://localhost:3000/api/birds/57692020c5231b94f8d78b36`
