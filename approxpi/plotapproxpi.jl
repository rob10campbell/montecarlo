#=
plotapproxpi.jl

Purpose:
    Using Monte Carlo methods, approximate π for a variety of populations of random numbers (n).
    Plot the approximation as a function of n to see if it converges to the true value of π.
    Plot the variance in each approximation as a function of 1/√n to see if the variance also decreases as we approach π (from statistics, variance should follow 1/√n -- plot of variance vs. 1/√n will be a straight line)

=#

using Distributions
using Gadfly
using Cairo
using Fontconfig

include("approxpi.jl")

ns1 = [n for n in 0:10:1000];
ns2 = [n for n in 1000:100:100000];

ns = append!(ns1,ns2);

πs = [approxpi(0,1,n) for n in ns];

pπ = plot(x=ns,y=πs,
    Geom.point, yintercept=[π], Geom.hline,
    Guide.xlabel("Number of random points (n)"),
    Guide.ylabel("Value of π"),
    Guide.title("Approximating π")
    );
draw(PNG("ApproxPi.png", 3inch, 3inch), pπ)

sqrts = [(1/√n) for n in 1:1000];
πvar = [var([approxpi(0,1,n) for n in 1:N]) for N in 1:1000];

pvar = plot(x=sqrts, y=πvar,
    Geom.point,
    Coord.Cartesian(xmin=0, xmax=0.1, ymin=0),
    Guide.xlabel("1/√n"),
    Guide.ylabel("Variance of approximation of π"),
    Guide.title("Variance vs. 1/√n")
    );
draw(PNG("VarApprox.png", 3inch, 3inch), pvar)
