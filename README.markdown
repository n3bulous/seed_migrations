### What? ###

Seed Migrations allow you treat seed data like migration data:

- each seed is imported only once
- seeds are imported in a specific order

### Why? ###

[db-populate](http://github.com/ffmike/db-populate/tree/master) and [seed-fu](http://github.com/mbleigh/seed-fu/tree/master) seemed overkill (though create\_or\_update is neat).  Seed-fu didn't appear to support ordering the imports, which makes handling FK relations complicated (i.e. enabling and disabling all constraints.)

While I was flip flopping like Al Gore, I found myself in a situation where the code had to be custom.  I saw a post by Mike Gunderloy on [A Fresh Cup](http://afreshcup.com/2009/05/11/seed-data-in-rails-3/) referring to seed data support in Rails 3.  A quick look revealed it to not be much of a feature, but a basic rake task to run a seeds.rb file which just happens to contain seed data (or not.)

### Anything to see here? ###

The only vaguely cool feature is a migration-style record of applied seed data imports.  This allows you to run the db:seed as many times as you like without repeating inserts.

### Installation ###

- `script/plugin git://github.com/n3bulous/seed_migrations.git`
- Copy _db/seeds.rb_ to your Rails' _db_ directory.

Obviously, if you already have a _db/seeds.rb_ you'll have to migrate.  The most simple way to achieve this is:

- `script/generate seed original_seeds`
- copy the current seeds.rb file into it
- prepend the seed file name (sans the .rb extension) to db/seeds/seed\_order.yaml
- if the existing seeds can't be re-run, insert the seed filename into the seedings table before running `rake db:seed` for the first time.

### Usage ###

- `./script/generate seed <a-descriptive-name>`
- Add Ruby and Rails code to the generated file in the db/seeds directory, e.g.:

<pre>
  cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
  Mayor.create(:name => 'Daley', :city => cities.first)
</pre>

- `rake db:seed`

The entries in _seed\_order.yaml_ are used as the key in the seedings table that keeps track of which ones have been inserted.

### Future ###

- db:seed:reset/up/down but this might be overkill.
- automate migrating from an pre-existing seeds.rb file.

### Thanks ###

- [Patrick Reagan](http://github.com/reagent/)
  - improve compatibility of the generator code

### License ###

Caveat Emptor
