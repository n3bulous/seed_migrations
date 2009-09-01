### Why? ###

A cursory glance at [db-populate](http://github.com/ffmike/db-populate/tree/master) and [seed-fu](http://github.com/mbleigh/seed-fu/tree/master).  Seed-fu didn't appear to support ordering the imports, which makes handling FK relations complicated (i.e. enabling and disabling all constraints.)

While I was flip flopping like Al Gore, I found myself in a situation where the code could had to be custom.  I saw a post by Mike Gunderloy on [A Fresh Cup](http://afreshcup.com/2009/05/11/seed-data-in-rails-3/) referring to seed data support in Rails 3.  A quick look revealed it to not be much of a feature, but a simple rake task that loads Rails code which just  happens to be seed data related (or not.)

### Anything to see here? ###

The only vaguely cool feature is a migration-style record of applied seed data imports.  This allows you to run the db:seed42 as many times as you like without repeating inserts.

### Installation ###

- Copy _seeds42\_task.rb_ to your Rails' _lib/tasks_ directory.
- Copy _seeds42.rb_ to your Rails' _db_ directory.

### Usage ###

- create _db/seeds/seed\_order.yaml_
- enter a 1-D array of seed data files (sans the .rb extension) in the order they should be inserted.

`- file_1`
`- file_2`
`- file_3`

- Create the seed files in the same directory. (e.g. from Rails 3 seeds.rb)

`cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
Mayor.create(:name => 'Daley', :city => cities.first)`

- `rake db:seed42`

The entries in _seed\_order.yaml_ are used as the key in the seedings table that keeps track of which ones have been inserted.

### Summary ###

This is just a quick overview.  If you are interested in a more formal introduction and tests, let me know.

### License ###

Caveat Emptor
