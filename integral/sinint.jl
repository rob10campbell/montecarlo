using Distributions
"""
    sinint(a,b,n)

Using Monte Carlo methods calculate I = ∫[sin(1/x)^2]dx over the interval (a,b)for a number of randomly selected points n
"""
function sinint(a,b,n)
    under = 0
    xdist = Uniform(a,b)
    ydist = Uniform(-1,1) # because the maximum value of the function is 1 in y
    for i in 1:n
        x = rand(xdist) # these points are only valid unscaled because the function is on interval 0,1 in y and x
        y = rand(ydist)
        
        y′ = sin(x)
        
        if y′ >= 0 && y <= y′
            under += 1
        elseif y′ < 0 && y >= y′
            under -= 1
        end
    end
    p = under / n
    Amax = (b - a) * (1 - -1)
    I = p * Amax
    return I
end
