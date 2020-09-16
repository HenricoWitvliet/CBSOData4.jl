module TestInterface
    using Test
    using CBSOData4

    include("mock_getodata.jl")

    tbls = CBSOData4.get_tables()
    @test length(tbls) > 0

end
