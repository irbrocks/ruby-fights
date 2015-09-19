# Introduction
Ruby fights is a repository to put Ruby methods face to face. There are some situations when we can use multiple methods to get same result, but what is the most efficient?

# Collaborate
Feel free to fork this project and add your own fights. The strutucture of every item is the same:

* Brief description about the situation. Link the methods to the documentation.
* Benchmarks results. I recommed you to use [Benchmark IPS gem](https://github.com/evanphx/benchmark-ips).
* Benchmark code stored in `benchmarks` folder with the name of the item. Add a link after benchmarks result.
* Conclusion about results. Cons of efficient solution...

# Index

## Collections

* [include? VS key?](#include-vs-key)
* [inject VS map and join](#inject-vs-map-and-join)

# Fights

## Collections

### include? VS key?

A lot of times I need to check if an item is included in a collection of elements. The first class I think to use is Array with its method [`include?`](http://ruby-doc.org/core-2.2.0/Array.html#method-i-include-3F). Another way is to use a Hash with elements as keys and true values for them. With this Hash I can use [`key?`](http://ruby-doc.org/core-2.2.0/Hash.html#method-i-key-3F) to check if an item is included in the collection.

```
Calculating -------------------------------------
            include?    89.010k i/100ms
                key?   105.873k i/100ms
-------------------------------------------------
            include?      2.275M (± 4.5%) i/s -     11.393M
                key?      3.590M (± 5.5%) i/s -     17.893M

Comparison:
                key?:  3590287.7 i/s
            include?:  2274510.3 i/s - 1.58x slower
```

Benchmark source: [key\_vs\_include.rb](https://github.com/irbrocks/ruby-fights/blob/master/benchmarks/key_vs_include.rb)

Hash with `key?` method is faster than Array and `include?` but allocation size of Hash is bigger. We must keep this in mind. As bonus of this fight, I will recommed you to read [Working with huge hashes in ruby](http://www.platanus.cz/blog/working-with-huge-hashes-in-ruby) if you have some memory problems.

### inject VS map and join

I have an Array of strings that we want to concatenate. Before concatenate them, I want to enclose them in a HTML li tag, because it will be added to a list. To perform this action I can [`map`](http://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-map) every item and edit them, and after join resulting Array. Another solution is to use [`inject`](http://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-inject) to concatenate items enclosing them in the tag.

```
Calculating -------------------------------------
              inject    10.993k i/100ms
            map/join    18.153k i/100ms
-------------------------------------------------
              inject    122.439k (± 7.4%) i/s -    615.608k
            map/join    242.233k (± 3.9%) i/s -      1.216M

Comparison:
            map/join:   242233.5 i/s
              inject:   122439.4 i/s - 1.98x slower
```

Benchmark source: [inject\_vs\_map\_join.rb](https://github.com/irbrocks/ruby-fights/blob/master/benchmarks/inject_vs_map_join.rb)

`inject` method is slower than `map` + `join`. The benchmark source use an array of 10 items, if we increase the number of elements the difference between methods is getting bigger. For example, if we set an array with 50 items, inject is 2.78x slower than `map` + `join`.