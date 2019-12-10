using Timeout
using Test

@testset "Timeout.jl" begin
    @test timeout(()->sleep(1), 2)() == nothing
    @test_throws TimeoutException timeout(()->sleep(2), 1)()
end
