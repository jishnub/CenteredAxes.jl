using CenteredAxes
using Test
using OffsetArrays

@testset "CenteredAxes.jl" begin
    @testset "Array" begin
        A = ones(3,3)
        I = to_indices(A, axes(A), (Centered(), :))
        @test I == (-1:1, 1:3)

        A = ones(2,2)
        I = to_indices(A, axes(A), (Centered(), 1:2))
        @test I == (-1:0, 1:2)
    end
    @testset "OffsetArrays" begin
        @testset "to_indices" begin
            A = ones(3:5, 3:5)
            I = to_indices(A, axes(A), (Centered(), :))
        	@test I == (-1:1, 3:5)
        	I = to_indices(A, axes(A), (Centered(), Centered()))
        	@test I == (-1:1, -1:1)
        	I = to_indices(A, axes(A), (3:4, Centered()))
        	@test I == (3:4, -1:1)

        	A = ones(7:8, 2:3)
        	I = to_indices(A, axes(A), (Centered(), :))
        	@test I == (-1:0, 2:3)
        	I = to_indices(A, axes(A), (:, Centered()))
        	@test I == (7:8, -1:0)
        end
        @testset "offset" begin
            @testset "Array" begin
                A = ones(2, 2)
                O = OffsetArray(A, Centered(), :)
                @test axes(O) == (-1:0, axes(A,2))
                O = OffsetArray(A, Centered(), Centered())
                @test axes(O) == (-1:0, -1:0)

                A = ones(3, 3)
                O = OffsetArray(A, Centered(), :)
                @test axes(O) == (-1:1, axes(A,2))
                O = OffsetArray(A, Centered(), Centered())
                @test axes(O) == (-1:1, -1:1)
            end
            @testset "OffsetArray" begin
                A = ones(2:3, 2:3)
                O = OffsetArray(A, Centered(), :)
                @test axes(O) == (-1:0, axes(A,2))
                O = OffsetArray(A, Centered(), Centered())
                @test axes(O) == (-1:0, -1:0)

                A = ones(2:4, 2:4)
                O = OffsetArray(A, Centered(), :)
                @test axes(O) == (-1:1, axes(A,2))
                O = OffsetArray(A, Centered(), Centered())
                @test axes(O) == (-1:1, -1:1)
            end
        end
    end
end
