CBSOData4
=========

[![Build Status](https://travis-ci.com/HenricoWitvliet/CBSOData4.jl.svg?branch=master)](https://travis-ci.com/HenricoWitvliet/CBSOData4.jl)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://HenricoWitvliet.github.io/CBSOData4.jl/dev)


This is a simple [Tables](https://github.com/JuliaData/Tables.jl)-interface to use the [CBS](https://opendata.cbs.nl/statline/portal.html?_la=nl&_catalog=CBS) odata4 beta portal to download CBS-datasets.

How to use it
-------------

If you know the exact dataset, you can directly use it:
```julia
using DataFrames, CBSOData4

df = DataFrame(CBSOData4.ODataTable_long("80072ned"))
```

You can use the keyword argument `columns` to give a list of column names to select (case sensitive). And you can use `filter` to give a filter expression for the rows (as a String) using the [Odata4](https://www.odata.org/documentation/odata-version-4-0/) rules.

For a given table you can get information about the columns in the dataset and about the used classifications by using `get_meta`:
```julia
df_meta = CBSOData4.get_meta("80072ned")
```
This gives a dict with Properties and the classifications.

Using `get_tables` you can get a list of dicts of all available tables. The `Identifier` can then be used to get the actual data.
