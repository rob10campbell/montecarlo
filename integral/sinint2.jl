using Distributions
using Gadfly

"""
    sinint(a,b,n)

Using Monte Carlo methods calculate I = ∫[sin(1/x)^2]dx over the interval (a,b)for a number of randomly selected points n
"""
function sinint(a,b,n)
    sum = 0.0
    xdist = Uniform(a,b)
    for i in 1:n
        x = rand(xdist)
        
        y = sin(x)
        sum += y

    end
    I = (b - a) * sum /n
    return I
end

varI(n,N) = var(sinint(0,2π, n) for _ in 1:N)
