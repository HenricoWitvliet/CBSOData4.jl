module CBSOData4

import HTTP
import JSON
import Tables

export get_tables, get_meta, ODataTable_long

BASE_URL = "http://beta-odata4.cbs.nl"
CATALOG = "CBS"

function get_odata(url)
    result = HTTP.get(url)
    data = JSON.parse(String(result.body))
end

"""
    get_tables(base, catalog)

Get all the tables in the catalog as a list of dicts. The `Identifier` can be 
used to get the actual data. If no parameters are given, the data is retrieved
from the (CBS)[https://www.cbs.nl] OData4 portal.

The optional parameters are:

  - base::String, basename of the OData4 server
  - catalog::String, path part of the OData4 server for catalog information

"""
function get_tables(base=BASE_URL, catalog=CATALOG)
    url = base * "/" * catalog * "/Datasets"
    return get_odata(url)["value"]
end


"""
    get_meta(table; base, catalog)

    Get the metadata for a given `table`. The result is a dict with the keys `"Dimensions"`, `"MeasureCodes"`, `"Properties"` and all the classifications (seperate codes and groups).

Optional parameters are:

  - base::String, basename of the OData4 server
  - catalog::String, path part of the OData4 server for regular data
"""
function get_meta(table; base=BASE_URL, catalog=CATALOG)
    tableurl = base * "/" * catalog * "/" * table
    metalinks = get_odata(tableurl)["value"]
    meta = Dict{String,Any}()
    for link in metalinks
        name = link["name"]
        if name in ("Observations", "Properties")
            continue
        end
        linkurl = tableurl * "/" * name
        meta[name] = get_odata(linkurl)["value"]
    end
    propurl = tableurl * "/Properties"
    meta["Properties"] = get_odata(propurl)
    return meta
end

function get_block(url)
    data = get_odata(url)
    nextlink = "@odata.nextLink" in keys(data) ? data["@odata.nextLink"] : nothing
    return (data["value"], nextlink)
end

function get_table(table; base=BASE_URL, catalog=CATALOG, columns=[], filter="")
    if length(columns) == 0
        select = ""
    else
        select = "&\$select=" * join(columns, ",")
    end
    if length(filter) > 0
        filter = "&\$filter=" * HTTP.escape(filter)
    end
    url = base * "/" * catalog * "/" * table * "/Observations?" * select * filter
    data = get_odata(url)
    nextlink = "@odata.nextLink" in keys(data) ? data["@odata.nextLink"] : nothing
    return (data["value"], nextlink)
end

function get_count(table; base=BASE_URL, catalog=CATALOG, columns=[], filter="")
    if length(columns) == 0
        select = ""
    else
        select = "&\$select=" * join(columns, ",")
    end
    if length(filter) > 0
        filter = "&\$filter=" * HTTP.escape(filter)
    end
    url = base * "/" * catalog * "/" * table * "/Observations?\$count=true&\$top=1" * select * filter
    data = get_odata(url)
    return data["@odata.count"]
end

struct ODataTable_long
    table::String
    block::Vector{Any}
    nextlink::Union{Nothing, String}
    names::Vector{Symbol}
    types::Vector{Type}
    length::Int
end

function firstline(t::ODataTable_long)
    datablock = getfield(t, :block)
    nextlink = getfield(t, :nextlink)
    row = 1
    return (OdataRow_long(datablock[row], t), (datablock, nextlink, row))
end

function nextline(t::ODataTable_long, status)
    datablock, nextlink, row = status
    if row == length(datablock) && !isnothing(nextlink)
        datablock, nextlink = get_block(nextlink)
        row = 0
    end
    row += 1
    if row > length(datablock)
        return nothing
    else
        return (OdataRow_long(datablock[row], t), (datablock, nextlink, row))
    end
end


struct OdataRow_long <: Tables.AbstractRow
    row::Dict{String, Any}
    table::ODataTable_long
end

Tables.istable(::ODataTable_long) = true
names(t::ODataTable_long) = getfield(t, :names)
Tables.columnnames(t::ODataTable_long) = getfield(t, :names)
types(t::ODataTable_long) = getfield(t, :types)
Tables.schema(t::ODataTable_long) = Tables.Schema(names(t), types(t))

Tables.rowaccess(::ODataTable_long) = true
Tables.rows(t::ODataTable_long) = t
Base.eltype(t::ODataTable_long) = OdataRow_long
Base.length(t::ODataTable_long) = getfield(t, :length)
Base.iterate(t::ODataTable_long) = firstline(t)
Base.iterate(t::ODataTable_long, st) = nextline(t, st)

Tables.getcolumn(r::OdataRow_long, s::String) = something(getfield(r, :row)[s], missing)
Tables.getcolumn(r::OdataRow_long, i::Int) = something(collect(values(getfield(r, :row)))[getfield(getfield(r, :table), :names)[i]], missing)
Tables.getcolumn(r::OdataRow_long, s::Symbol) = something(getfield(r, :row)[String(s)], missing)

Tables.columnnames(r::OdataRow_long) = collect(keys(getfield(r, :row)))
Base.NamedTuple(r::OdataRow_long) = NamedTuple{Tuple(Symbol.(keys(getfield(r, :row))))}(values(getfield(r, :row)))

function ODataTable_long(table; columns=[], filter="", base=BASE_URL, catalog=CATALOG)
    recordcount = get_count(table, base=base, catalog=catalog, columns=columns, filter=filter)
    nextblock, nextlink = get_table(table, base=base, catalog=catalog, columns=columns)
    meta = get_meta(table)
    names = Symbol.(collect(keys(nextblock[1])))
    types = [typeof(nextblock[1][String(name)]) for name in names]
    return ODataTable_long(table, nextblock, nextlink, names, types, recordcount)
end



end # module
