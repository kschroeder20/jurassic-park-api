A REST API built completely on Ruby on Rails. The API allows workers at Jurrasic Park to keep track of the different cages around the park and the different dinosaurs in each one.

## To Start:

1. Pull repo to local machine and `cd` into repo director
2. `rake db:create && rake db:migrate && rake db:seed` - sets up database
3. `bundle install`
4. `rails s` - start server
5. In another terminal, use a HTTP client to make requests to the API. I recommend HTTPie (https://httpie.io/)

## Endpoints:

### Cages:

|  HTTP Method   |  Endpoint               |  Function       |
|  ------------- |  -------------          |  -------------
| GET            |  /cages                 | Returns all cages
| GET            |  /cages/:id             | Returns a specific cage
| GET            |  /cages/status/active   | Returns all active cages
| GET            |  /cages/status/inactive | Returns all inactive cages
| GET            |  /cages/:id/dinosaurs   | Returns dinosaurs in a specific cage
| POST           |  /cages                 | Create a cage
| PUT            |  /cages/:id             | Edit a cage
| DELETE         |  /cages/:id             | Delete a cage

### Dinosaurs:

|  HTTP Method   |  Endpoint                   |  Function       |
|  ------------- |  -------------              |  -------------
| GET            |  /dinosaurs                 | Returns all dinosaurs
| GET            |  /dinosaurs/:id             | Returns a specific dinosaur
| GET            |  /dinosaurs/species/:species| Returns all dinosaurs of a species
| POST           |  /dinosaurs                 | Create a dinosaur
| PUT            |  /dinosaurs/:id             | Edit a dinosaur
| DELETE         |  /dinosaurs/:id             | Delete a dinosaur


## Future Improvements:
* Add authentication feature (i.e. API key)
* Add a bulk-edit or bulk-create option
* Improve/QA header and statuses
* Impliment a full state comparison or locking to handle concurrent requests
* Impliment error handling for concurrent request that doesn't stop functionality
