# Custom ORM

This project was meant to explore how ActiveRecord implements its object-relational mapping. Recreated the core functionality which would allow me to use this as my own ORM in future projects if I wanted to.

## SQLObject

The goal here was to create a SQLObject class that would interact with the database. It also carries with it some common methods for DB lookup: namely `::all` and `::find`

I also implemented `#save` and `#update`, which would allow me to make changes to the database using this class.

## Searching

The next aspect I tackled was searching the DB for a specific object, so I recreated `::where`. I extended my original class to allow my Searchable module to be mixed in.

## Associations.

Here I took on associations. I started with `belongs_to` and `has_many`, as their structures paralleled each other. Tracking foreign_keys, primary_keys, and the corresponding classes proved vital to organizing and piecing together what I needed. Lastly I decided to implement a `has_one_through` association as well. This proved a little more intense, as I had to keep track of a few more variables. 
