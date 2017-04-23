"""
    approxpi(a, b, n)

This function uses Monte Carlo methods to approximate π by considering the ratio:
    
        Area Under a Curve / Total Area
    
where:

    a, b = bounds of the total area (i.e. bounds of a uniform random distribution)
    n = number of randomly selected points

It requires using Distributions.jl
    
For calculating π:
Considering the analogy of a circular target on a square dartboard, random points are selected within a 1x1 square. (a = 0, b = 1) 

The number of points that fall within the circle inscribed within this square are calculated. (f = x^2 + y^2 <= 1)

The proportion of points inside the circle vs. the total number of points reflects the ratio of the area of the circle to the area of the square. (p = m/n) 

In order to approximate pi, the result (p) needs to be multiplied by four (Area_cirlce / Area_Square = π/4 ; 4*p = π).
"""
function approxpi(a, b, n)
    dist = Uniform(a,b) #establish that we are using a Unifrom distribution
    m = 0 #number of points within the circle
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

        if x^2 + y^2 <= 1 #condition for being inside the circle
            m+=1
        end
    end
    p =  m/n
    return 4*p
end
