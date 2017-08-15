using BasisMatrices
using Plots
using Benchmarks
pyplot()


f(x) = (1 + 25*x.^2).^-1.

x = linspace(-1,1,1000)

#best performance
@benchmark map(f,x)

function create_fhat(f; n=20)
  basis = Basis(ChebParams(n, -1, 1))
  #S, (grid, ) = nodes(basis)
  #Φ = BasisMatrix(basis, Expanded(), grid)

  #y = map(f,S)
  #Φ.vals[1] \ y

  interp = Interpoland(basis, f)

  fhat(x) = BasisMatrix(basis,Expanded(), x).vals[1] * interp.coefs
end


fhat = create_fhat(f, n=10)

plot(x, [fhat(x), f(x)], label = ["interpolated" "Runge"])
#scatter!(grid, y, label = "nodes")
