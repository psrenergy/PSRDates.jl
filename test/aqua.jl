function test_aqua()
    @testset "Aqua.jl" begin
        @testset "Ambiguities" begin
            Aqua.test_ambiguities(PSRDates; recursive = false)
        end
        Aqua.test_all(PSRDates; ambiguities = false)
    end
end
