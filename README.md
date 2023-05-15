# Moved from old repo due to mismatching config push https://github.com/Writtek07/Invoice_final

* DO NOT upgrade or downgrade, use this exact versions, as issues with deployment as well as system and other node libraries which require this exact config to work.

* Ruby version -> `2.5.0`

## System dependencies
 * Node version -> `v12`

## Database creation
 * Now using psql in local as well. 

## Database initialization (For Dev only)
 * database: `mimis`
 * username: `postgres`
 * password: `password`


## Steps to use in dev mode
* Git clone the repo after setting the local system with above requirements.
* gem update --system 3.2.3
* bundle install
* Then if needed `yarn install --check-files`
* `rails s` 
