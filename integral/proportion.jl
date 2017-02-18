"""
    proportion(f, a, b, n)

This function uses a Monte Carlo approximation to find the ratio:
    
        Area Under a Curve / Total Area
    
where:

    f = function of x and y defining a curve
        ("julia> f(x,y) = x+y
          f (generic function with 1 method)"
      or "julia> f = (x, y) -> x+3y
          (anonymous function)"
    a, b = bounds of the uniform distribution
    n = number of randomly selected points

It can be used to approximate pi by considering the analogy of a circular target on a square dartboard, random points are selected within a 1x1 square. (a = 0, b = 1) 

The number of points that fall within the circle inscribed within this square are calculated. (f = x^2 + y^2 <= 1)

The proportion of points inside the circle vs. the total number of points reflects the ratio of the area of the circle to the area of the square. (p = m/n) 

In order to approximate pi, the result (p) needs to be multiplied by four (Area_cirlce / Area_Square = π/4 ; 4*p = π).
"""
function proportion(f, a, b, n)
    using Distributions
    dist = Unifrom(a,b)
    m = 0 #number of points within the circle
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

        if f #condition for a function of x and y that defines the curve
            m+=1
        end
    end
    return p =  m/n
end
