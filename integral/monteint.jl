#=
Purpose:

using Monte Carlo methods, approximate the integral of cos(x) for a variety of populations of random numbers (n);

plot the approximation as a function of n to see if it converges to the true value of the integral of cos(x);

plot the variance in each approximation as a function of 1/√n to see if the variance decreases as we expect (from statistics, variance should follow 1/√n -- the plot of the variance vs. 1/√n will be a straight line).

        =#

using Distributions
using Gadfly
using Cairo
using Fontconfig

function approxcos(a, b, n)
    dist = Uniform(a, b) #establish that we are using a Uniform distribution
    sumy = 0
    for i in 1:n
        x = 2*π*rand(dist)
        y = cos(x)

        sumy += y

    end
    meany = sumy/n
    return meany
end

ns = collect(10^i for i in 0:9); #set of integer quantities of random numbers for Monte Carlo approximation

coss = [approxcos(0,1,n) for n in ns]; #approximations of the integral of cos(x) for a given quantity of random numbers

plotcos = plot(x=ns, y=coss,
    Geom.point,
    Guide.xlabel("Number of random points (n)"),
    Scale.x_log10,
    Guide.ylabel("Approximated value of cos(x)"),
    Guide.title("Monte Carlo approximation of cos(x) for n random numbers")
    );
draw(PNG("ValuesCos.png", 150mm, 150mm), plotcos)

function monterror(n, N) #given a quantity of random numbers

    #find the error for this calculation
    sum_ys = 0
    sum_ysquare = 0

    for i in 1:N
        y = approxcos(0,1,n)
        sum_ys += y
        sum_ysquare += y^2
    end

    mean_n = sum_ys / N
    mean_nsquare = sum_ysquare / N

    variance = (mean_nsquare - (mean_n)^2)

    return int_error = √(variance / N)
end

#since estimate of variance must converge on 1/2, estimate of error must converge on 1/√(2 n)

sqrts_n = [(1/√(2*n)) for n in ns];

#π_variance = [monterror(n) for n in ns]

y_errors = [monterror(n, 10) for n in ns]

ploterror = plot(x=sqrts_n, y=y_errors,
        Geom.point,
        Guide.xlabel("1/√2*n"),
        Guide.ylabel("Error in the approximation of cos(x)"),
        Guide.title("Error in calculations should scale as 1/√(2*n)")
        );
draw(PNG("ErrorsCos.png", 150mm, 150mm), ploterror)
