module TestMeta
    using Test
    using CBSOData4

    include("mock_getodata.jl")

    meta_880072ned = CBSOData4.get_meta("80072ned")
    @test "Properties" in keys(meta_880072ned)
    @test Set(["PeriodenGroups", "BedrijfskenmerkenSBI2008Codes", "BedrijfskenmerkenSBI2008Groups", "Dimensions", "MeasureCodes", "PeriodenCodes", "Properties"]) == Set(keys(meta_880072ned))

end
