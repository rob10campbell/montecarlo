#=
cos2int.jl

Purpose: Use Monte Carlo methods to apprximate the integral ∫[cos(x)cos(y)]dx over the interval (a,b) for a number of random points n
=#
using Distributions
using Gadfly
using Cairo
using Fontconfig

function cos2int(a,b,n)
    under = 0
    xmax = b - a
    fmax = cos(xmax)*cos(xmax)
    dist = Uniform(a,b)
    for i in 1:n
        x = rand(dist)
        y = rand(dist)
        
        if (fmax * y) < cos(x)cos(y)
            under += 1
        end
    end
    p = (under / n) * xmax * fmax
    return p
end

xs = [x for x in 1:1000];
cos2ys = [cos2int(0,2π,n) for n in xs];

pcos2 = plot(x=xs, y=cos2ys,
            Geom.point,
            Guide.xlabel("Number of points (n)"),
            Guide.ylabel("Approximation of I"),
            Guide.title("Approximating I = ∫cosxcosy from 0 to 2π ")
        );
draw(PNG("Cos2Approx.png", 150mm, 150mm), pcos2)

sqrts = [(1/√n) for n in xs];
cos2vars = [var([cos2int(0,2π,n) for n in 1:N]) for N in xs];

pcos2vars = plot(x=sqrts, y=cos2vars,
                Geom.point,
                Guide.xlabel("1/√n"),
                Guide.ylabel("Variance of the Approximation of I"),
                Guide.title("Variance in Approximation of I = ∫cos(x)cos(y) from 0 to 2π")
            );
draw(PNG("Cos2Var", 150mm, 150mm), pcos2vars)
