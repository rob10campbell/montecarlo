#=
Purpose:

using Monte Carlo methods, approximate π for a variety of populations of random numbers (n);

plot the approximation as a function of n to see if it convrges to the true value of π;

plot the variance in each approximation as a function of 1/√n to see if the variance decreases as we expect (from statistics, variance should follow 1/√n -- the plot of the variance vs. 1/√n will be a straight line).

        =#

using Distributions
using Gadfly
using Cairo
using Fontconfig

function approxpi(a, b, n)
    dist = Uniform(a, b) #establish that we are using a Uniform distribution
    m = 0 #number of points within the circle
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

        if x^2 + y^2 <= 1 #condition for being inside the circle
            m += 1
        end
    end
    p = m/n
    return 4*p
end

ns = linspace(1,1000); #logspace(0,10); #set of quantities of random numbers for Monte Carlo approximation
#ns must be INTEGERS for monterror to work D:

πs = [approxpi(0,1,n) for n in ns]; #approximations of pi for a given quantity of random numbers

plotπ = plot(x=ns, y=πs,
    Geom.point, yintercept=[π], Geom.hline,
    Guide.xlabel("Number of random points (n)"),
    Guide.ylabel("Approximated value of π"),
    Guide.title("Monte Carlo approximation of π for n random numbers")
    );
draw(PNG("ValuesPi.png", 150mm, 150mm), plotπ)

function monterror(n) #given a quantity of random numbers

    #find the error for this calculation
    sum_πs = 0
    sum_πsquare = 0
    
    i = 1

    if i <= n #sum for each value i in i:n
        sum_πs += approxpi(0,1,i) 
        sum_πsquare += ((approxpi(0,1,i)))^2
        i += 1
    end

    mean_n = sum_πs / n
    mean_nsquare = sum_πsquare / n

    variance = mean_nsquare - (mean_n)^2

    return π_error = √(variance / n)
end

return monterror(100)

#since estimate of variance must converge on 1/2, estimate of error must converge on 1/√(2 n)

sqrts_n = [(1/√(2*n)) for n in ns];

π_errors = [monterror(n) for n in ns]
#=
ploterror = plot(x=sqrts_n, y=π_errors,
        Geom.point,
        Guide.xlabel("1/√n"),
        Guide.ylabel("Error in the approximation of pi"),
        Guide.title("Error in calculations should scale as 1/√(2*n)")
        );
draw(PNG("ErrorsPi.png", 150mm, 150mm), ploterror)
=#
