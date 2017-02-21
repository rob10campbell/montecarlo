"""
cos2int(a,b,n)

Using Monte Carlo methods to apprximate the integral ∫[cos(x)cos(y)]dx over the interval (a,b) for a number of random points n

Requires Distributions.jl
"""
function cos2int(a,b,n)
    under = 0
    xmax = b - a
    dist = Uniform(a,b)
    for i in 1:n
        x = rand(dist)
        y = rand(dist)
        
        if cos(xmax*x)cos(xmax*y) < cos(x)cos(y)
            under += 1
        end
    end
    p = (under / n)
    return p
end

