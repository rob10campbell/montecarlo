"""
This is my code because I don't know how to put it somewhere proper
"""

using Distributions

using Gadfly

include("approxpi.jl")

ns1 = [n for n in 0:10:1000];

ns2 = [n for n in 1000:100:100000];

ns = append!(ns1,ns2);

πs = [approxpi(0,1,n) for n in ns];

plot(x=ns,y=πs,
    yintercept=[π],Geom.point,Geom.smooth,Geom.hline,
    Guide.xlabel("Number of points (n)", Guide.ylabel("Value of π"), Guide.title("Approximating π"))
