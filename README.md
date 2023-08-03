* Last stable merge on the earlier repo -> https://github.com/Writtek07/Invoice_final/pull/91 

# DO NOT upgrade or downgrade, use this exact versions, as issues with deployment as well as OS and other node libraries which require this exact config to work.

* Ruby version -> `2.5.0`

## System dependencies
 * Node version -> `v12.22.12`
 * Windows command to set node version if node and npm already installed :-
 1. List all available node versions -> `nvm ls`
 2. Use the defined version -> `nvm use v12.22.12`
 * Install the packages if error.
 

## Database creation
 * Now using psql in local as well. 

## Database initialization (For Dev only)
 * database: `mimis`
 * username: `postgres`
 * password: `password`


## Steps to use in dev mode
* Git clone the repo after setting the local system with above requirements.
* `gem update --system 3.2.3`
* `bundle install`
* Then if needed `yarn install --check-files`
* `rails s` 
## Since now ActiveJob is also added using redis
# Run this command to start sidekiq also in new tab with rails server
* `bundle exec sidekiq` - Credentials in credentails.yml.enc. Open the decyrpted file to see the url

## Dumping from Prod to Local.
* Download the dump(.sql.gz) from render.
* Extract to `/code` of wsl by running `gzip -d file_name.sql.gz`
* `sudo -i -u postgres`
* Inside postgres ->  Drop existing table(if present), and run -> `CREATE DATABASE mimis;` 
* Exit out to `/code/` and run `sudo -u postgres psql -d mimis -f 2023-05-14T19_06Z.sql`

## Project PPT
decktop.us/ysjBknEPl
