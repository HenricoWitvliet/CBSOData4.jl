var documenterSearchIndex = {"docs":
[{"location":"#CBSOData4.jl","page":"CBSOData4.jl","title":"CBSOData4.jl","text":"","category":"section"},{"location":"","page":"CBSOData4.jl","title":"CBSOData4.jl","text":"Documentation for CBSOData4.jl","category":"page"},{"location":"","page":"CBSOData4.jl","title":"CBSOData4.jl","text":"Modules = [CBSOData4]\nOrder   = [:type, :function]","category":"page"},{"location":"#CBSOData4.ODataTable_long-Tuple{Any}","page":"CBSOData4.jl","title":"CBSOData4.ODataTable_long","text":"ODataTable_long(table; columns, filters, base, catalog)\n\nGet a Tables object for the dataset defined by table. Optional parameters are:\n\ncolumns::Vector{String}, exact columnnames to select, empty for all columns\nfilters::String, OData4 specification for row filter\nbase::String, basename of the OData4 server\ncatalog::String, path part of the OData4 server for catalog information\n\nExamples\n\ntbl = CBSOData4.ODataTable_long(\"82931NED\", filter=\"Measure in ['T001036']\")\n\n\n\n\n\n","category":"method"},{"location":"#CBSOData4.get_catalogs","page":"CBSOData4.jl","title":"CBSOData4.get_catalogs","text":"get_catalogs(base)\n\nGet all the catalogs as a list of dicts. The Identifier can be used as the catalog for queries about datasets in a certain catalog.  If no parameters are given, the data is retrieved from the (CBS)[https://www.cbs.nl] OData4 portal.\n\nThe optional parameter is:\n\nbase::String, basename of the OData4 server\n\n\n\n\n\n","category":"function"},{"location":"#CBSOData4.get_meta-Tuple{Any}","page":"CBSOData4.jl","title":"CBSOData4.get_meta","text":"get_meta(table; base, catalog)\n\nGet the metadata for a given `table`. The result is a dict with the keys `\"Dimensions\"`, `\"MeasureCodes\"`, `\"Properties\"` and all the classifications (seperate codes and groups).\n\nOptional parameters are:\n\nbase::String, basename of the OData4 server\ncatalog::String, path part of the OData4 server for regular data\n\n\n\n\n\n","category":"method"},{"location":"#CBSOData4.get_tables","page":"CBSOData4.jl","title":"CBSOData4.get_tables","text":"get_tables(base, catalog)\n\nGet all the tables in the catalog as a list of dicts. The Identifier can be  used to get the actual data. If no parameters are given, the data is retrieved from the (CBS)[https://www.cbs.nl] OData4 portal.\n\nThe optional parameters are:\n\nbase::String, basename of the OData4 server\ncatalog::String, path part of the OData4 server for catalog information\n\n\n\n\n\n","category":"function"}]
}
