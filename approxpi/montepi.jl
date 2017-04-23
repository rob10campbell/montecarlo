#=
Purpose:

using Monte Carlo methods, approximate π for a variety of populations of random numbers (n);

plot the approximation as a function of n to see if it convrges to the true value of π;

plot the error in each approximation as a function of 1/√(2*n) to see if the error decreases as we expect (from statistics, variance should follow 1/√n and error should follow 1/\swrt (2*n) -- the plot of the variance vs. 1/√n will be a straight line; the plot of error vs. 1/(2*n) will be a straight line).

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

ns = collect(10^i for i in 0:9); #set of integer quantities of random numbers for Monte Carlo approximation

πs = [approxpi(0,1,n) for n in ns]; #approximations of pi for a given quantity of random numbers

plotπ = plot(x=ns, y=πs,
    Geom.point, yintercept=[π], Geom.hline,
    Guide.xlabel("Number of random points (n)"),
    Scale.x_log10,
    Guide.ylabel("Approximated value of π"),
    Guide.title("Monte Carlo approximation of π for n random numbers")
    );
draw(PNG("ValuesPi.png", 150mm, 150mm), plotπ)

function monterror(n, N) #given a quantity of random numbers

    #find the error for this calculation
    sum_πs = 0
    sum_πsquare = 0

    for i in 1:N
        y = approxpi(0,1,n)
        sum_πs += y
        sum_πsquare += y^2
    end

    mean_n = sum_πs / N
    mean_nsquare = sum_πsquare / N

    variance = (mean_nsquare - (mean_n)^2)

    return π_error = √(variance / N)
end

#since estimate of variance must converge on 1/2, estimate of error must converge on 1/√(2 n)

sqrts_n = [(1/√(2*n)) for n in ns];

#π_variance = [monterror(n) for n in ns]

π_errors = [monterror(n, 10) for n in ns]

ploterror = plot(x=sqrts_n, y=π_errors,
        Geom.point,
        Guide.xlabel("1/√2*n"),
        Guide.ylabel("Error in the approximation of pi"),
        Guide.title("Error in calculations should scale as 1/√(2*n)")
        );
draw(PNG("ErrorsPi.png", 150mm, 150mm), ploterror)
