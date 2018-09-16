# Moon Shots API

A graphql API for the [Moon Shots Client](https://github.com/lucyconklin/moon-shots-client)

## Getting started

`rails db:create`
`rails db:migrate`

#### Add some seed data and import a JSON file

Open up your rails console
`rails c`

Load the json importer
`load "./lib/utilities/json_importer.rb"`

Create some seed data with the help of my favorite gem: Faker. This will write it to a JSON file.
`create_seed_data("./lib/utilities/data.json")`

Import that file we just made here:
`BarrelImporter.new("./lib/utilities/data.json")`

You will see a helpful and colored output of the results like this:
`5 Satellites Created! 28 Barrels Created!`

## Notes

1. graphql
1. postgres array column type
1. sorting on the back end
