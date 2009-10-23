### UPDATE - 2009-10-23 ###
Finally got around to tweaking this after Rails 2.3.4 backported their generic seed support from Rails 3.

### What? ###

Seed Migrations allow you treat seed data like migration data:

- You only run it once.
- They should be run in a specific order.

### Why? ###

[db-populate](http://github.com/ffmike/db-populate/tree/master) and [seed-fu](http://github.com/mbleigh/seed-fu/tree/master) seemed overkill (though create\_or\_update is neat).  Seed-fu didn't appear to support ordering the imports, which makes handling FK relations complicated (i.e. enabling and disabling all constraints.)

While I was flip flopping like Al Gore, I found myself in a situation where the code had to be custom.  I saw a post by Mike Gunderloy on [A Fresh Cup](http://afreshcup.com/2009/05/11/seed-data-in-rails-3/) referring to seed data support in Rails 3.  A quick look revealed it to not be much of a feature, but a simple rake task that loads Rails code which just  happens to be seed data related (or not.)


### Anything to see here? ###

The only vaguely cool feature is a migration-style record of applied seed data imports.  This allows you to run the db:seed as many times as you like without repeating inserts.

### Installation ###

- Copy _db/seeds.rb_ to your Rails' _db_ directory.

### Usage ###

- `./script/generate seed <a-descriptive-name>`
- Add Ruby and Rails code to the generated file in the db/seeds directory, e.g.:

<pre>
  cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
  Mayor.create(:name => 'Daley', :city => cities.first)
</pre>

- `rake db:seed`

The entries in _seed\_order.yaml_ are used as the key in the seedings table that keeps track of which ones have been inserted.

### Summary ###

This is just a quick overview.  It should work fine, though I've made a number of tweaks/improvements from the production (i.e. known working) version.

If you are interested in a more formal introduction and tests, let me know.

### License ###

Caveat Emptor
