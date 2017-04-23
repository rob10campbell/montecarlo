#=
Purpose:
To calculate the integral of a function using Monte Carlo Methods

    Plots -- approximation of the integral for various quantities of random numbers (n)
             variance of the approximation with respect to 1/√n -- should follow what we expect from statistics (plot as a straight line)
             error of the approximation with respect to 1/√(2*n) -- should follow what we expect from statistics (plot as a straight line)

    =#

using Distributions
using Gadfly
using Cairo
using Fontconfig

ns = [1,10]

function ys(n)
    dist = Uniform(0,1) #establish that we are using a Uniform distribution
    ys = []

    for i in 1:n
        x = 2*π*rand(dist)
        y = (sin(x))^2
        
        push!(ys, y)
    end
end

sumy = sum(ys)

sumysquares = 0

for y in ys
    sumysquares += y^2
end

meany = sumys / n #the approximation of the integral is the mean value of all n approximations
    
integral = meany

meanysquare = sumysqares / n

manualvariance = meanysquare - (meany)^2

error = √(manualvariance / n)
 


#=
sqrts = [(1/√(n)) for n in range(1,n)]

plotvar = plot(x=sqrts, y=vars,
    Geom.point, Guide.title("Variance of Monte Carlo Integral of Sin(x)^2")
    );
draw(PNG("VaraincePlot.png", 150mm, 150mm), plotvar)
=#
