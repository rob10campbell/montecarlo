"""
    proportion(f, a, b, n)

This function uses a Monte Carlo approximation to find the ratio:
    
        Area Under a Curve / Total Area
    
where:

    f = implicit function of x and y defining a curve
        ("julia> f(x,y) = x+y
          f (generic function with 1 method)"
      or "julia> f = (x, y) -> x+3y
          (anonymous function)"
    a, b = bounds of the integral
    n = number of randomly selected points

It requires using Distributions.jl
"""
function proportion(f, a, b, n)
    using Distributions
    dist = Unifrom(a,b)
    under = 0 #number of points under the curve
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

        if f(x,y) < 0 
            m+=1
        end
    end
    return p =  under / n
end
