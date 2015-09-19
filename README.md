# Introduction
Ruby fights is a repository to put Ruby methods face to face. There are some situations when we can use multiple methods to get same result, but what is the most efficient?

# Collaborate
Feel free to fork this project and add your own fights. The strutucture of every item is the same:

* Brief description about the situation. Link the methods to the documentation.
* Benchmarks results. I recommed you to use [Benchmark IPS gem](https://github.com/evanphx/benchmark-ips).
* Benchmark code stored in `benchmarks` folder with the name of the item. Add a link after benchmarks result.
* Conclusion about results. Cons of efficient solution...

# Index

## Enumerable

* [`inject` VS `map` and `join`]()

# Fights

## Enumerable 

### `inject` VS `map` and `join`

I have an Array of strings that we want to concatenate. Before concatenate them, I want to enclose them in a HTML li tag, because it will be added to a list. To perform this action I can [map](http://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-map) every item and edit them, and after join resulting Array. Another solution is to use [inject](http://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-inject) to concatenate items enclosing them in the tag.

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

Benchmark source: [inject\_vs\_map\_join]()

`inject` method is slower than `map` + `join`. The benchmark source use an array of 10 items, if we increase the number of elements the difference between methods is getting bigger. For example, if we set an array with 50 items, inject is 2.78x slower than `map` + `join`.