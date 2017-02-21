"""
cos2int(a,b,n)

Using Monte Carlo methods to apprximate the integral ∫[cos(x)]^2 dx over the interval (a,b) for a number of random points n

Requires Distributions.jl
"""
function cos2int(a,b,n)
    under = 0
    xmax = b-a
    fmax = cos(xmax)^2
    dist = Uniform(a,b)
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

        if fmax * y < cos(x)^2
            under += 1
        end
    end
    p = (under / n) * xmax * fmax
    return p
end
