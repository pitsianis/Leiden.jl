
@testset "Leiden.jl simple tests" begin
  A = spdiagm(1 => ones(Int64,7), -1 => ones(Int64,7));

  for (γ,g) in [(0.25,1), (1.0,2), (2.0,4), (4.0,6), (8.0,8)]
      l, v = Leiden._do_leiden(A,"mod++"; γ) 
      @test length(unique(l)) == g
  end
end
