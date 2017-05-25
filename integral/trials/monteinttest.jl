#=
Purpose: to calculate the integral of a function using Monte Carlo Methods

    Plots -- approximation of the integral for various quantities of random numbers (n)
             variance of the approximation with respect to 1/√n -- should follow what we expect from statistics (plot as a straight line)
             error of the approximation with respect to 1/√(2*n) -- should follow what we expect from statistics (plot as a straight line)

    =#

using Distributions
using Gadfly
using Cairo
using Fontconfig

ns = [10^i for i in 0:5]

function manualvariance(n) 
    dist = Uniform(0,1) #establish that we are using a Uniform distribution
    sumy = 0
    sumy2 = 0

    for i in 1:n
        x = 2*π*rand(dist)
        y = (sin(x))^2
        
        sumy += y
        
        sumy2 += y^2
    end
    
    meany = sumy / n

    meany2 = sumy2 / n
    
    manvar = meany2 - meany^2
    return manvar
end

errors = [√(manualvariance(n)/n) for n in ns];

return errors

#=
ns = [10^i for i in 0:5]

sarray = [sin2ys(n) for n in ns]

return sarray

integrals = []

errors = []

for ys in sarray
    sumy = sum(ys)
    
    sumysquares = 0

    for y in ys
        sumysquares += y^2
    end

    meany = sumy / n #the approximation of the integral is the mean value of all n approximations
    
    integral = meany

    push!(integrals, integral)

    meanysquare = sumysqares / n

    manualvariance = meanysquare - (meany)^2

    error = √(manualvariance / n)

    push!(errors, error)

end

return integrals
return errors
=#
#=
ploterror = plot(x=errors, y=ns,
    Geom.point, Guide.title("Error of Monte Carlo Integral of Sin(x)^2")
    );
draw(PNG("ErrorPlot.png", 150mm, 150mm), ploterror)
=#
