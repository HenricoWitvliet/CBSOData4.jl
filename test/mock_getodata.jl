using JSON

# replace get_odata for testing
function CBSOData4.get_odata(url)
    if url == "http://beta-odata4.cbs.nl/CBS/Datasets"
        content = JSON.parse(String(open("meta_10.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS"
        content = JSON.parse(String(open("meta_1.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned"
        content = JSON.parse(String(open("meta_2.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/Observations?\$count=true&\$top=1"
        content = JSON.parse(String(open("meta_3.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/Observations?"
        content = JSON.parse(String(open("meta_4.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/MeasureCodes"
        content = JSON.parse(String(open("meta_5.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/Dimensions"
        content = JSON.parse(String(open("meta_6.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/Properties"
        content = JSON.parse(String(open("meta_7.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/PeriodenGroups"
        content = JSON.parse(String(open("meta_8.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/PeriodenCodes"
        content = JSON.parse(String(open("meta_9.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/BedrijfskenmerkenSBI2008Groups"
        content = JSON.parse(String(open("meta_10.json") do io read(io) end))
        return content
    elseif url == "http://beta-odata4.cbs.nl/CBS/80072ned/BedrijfskenmerkenSBI2008Codes"
        content = JSON.parse(String(open("meta_11.json") do io read(io) end))
        return content
    else
        println("Fout:" * url)
        return Dict("value"=>nothing)
    end
end
