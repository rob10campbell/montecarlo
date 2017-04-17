#=
Purpose:
To calculate the integral of a function using Monte Carlo Methods
=#

using Distributions
using Gadfly
using Cairo
using Fontconfig

n = 1000

vars = []

for i in range(1,n)
    dist = Uniform(0,1)
    sumys = 0
    sumysquares = 0

    for i in 1:n
        x = 2*π*rand(dist)
        
        y = (sin(x))^2

        sumys += y
        sumysquares += y^2
    end

    meany = sumys / n

    meanysquare = sumysquares / n

    variance = meanysquare - (meany)^2
   
    push!(vars, variance)
end

sqrts = [(1/√(n)) for n in range(1,n)]

plotvar = plot(x=sqrts, y=vars,
    Geom.point, Guide.title("Variance of Monte Carlo Integral of Sin(x)^2")
    );

#draw(PNG("VaraincePlot.png", 150mm, 150mm, plotvar))

