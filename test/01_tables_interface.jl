module TestInterface
    using Test
    using CBSOData4

    include("mock_getodata.jl")
    
    tbl = CBSOData4.ODataTable_long("80072ned")
    @test length(tbl) == 4409
end
