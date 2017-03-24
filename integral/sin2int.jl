using Distributions
"""
    sin2int(a,b,n)

Using Monte Carlo methods calculate I = ∫[sin(1/x)^2]dx over the interval (a,b)for a number of randomly selected points n
"""
function sin2int(a,b,n)
    under = 0
    xdist = Uniform(a,b)
    ydist = Uniform(0,1) # because the maximum value of the function is 1 in y
    for i in 1:n
        x = rand(xdist) # these points are only valid unscaled because the function is on interval 0,1 in y and x
        y = rand(ydist)

        if y <= sin(x)^2 # this method works because the function is always positive
            under += 1
        end
    end
    p = under / n
    Amax = (b - a) * (1 - 0)
    I = p * Amax
    return I
end
