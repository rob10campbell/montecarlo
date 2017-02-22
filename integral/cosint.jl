#=
cosint.jl

Purpose: 
Use Monte Carlo methods to integrate y=cos(x) over an interval (a,b)
Graph the approximation of [∫cos(x)dx] over (a,b)
Graph the variance of the approximation with respect to 1/√n
=#
using Distributions
using Gadfly
using Cairo
using Fontconfig

function cosint(a,b,n)
    under = 0
    xmax = b - a
    fmax = cos(xmax)
    dist = Uniform(a,b)
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

	    if fmax * y < cos(x)
            under += 1
	    end
    end
    p = (under / n) * xmax * fmax 
    return p
end

xs = [x for x in 1:1000];
approxcos = [cosint(0,2π,n) for n in xs];

pcos = plot(x=xs, y=approxcos,
    Geom.point,
    Guide.xlabel("Number of points (n)"),
    Guide.ylabel("Approximation of I"),
    Guide.title("Approximating I = [∫cos(x)dx] from 0 to 2π")
    );
draw(PNG("ApproxIntCos.png"), 3inch, 3inch), pcos)

sqrts = [(1/√x) for x in xs];
vars = [var([cosint(0,2π,n) for n in 1:N]) for N in xs];

pcosvar = plot(x=sqrts, y=vars,
    Coord.Cartesian(xmin=0, xmax=0.5, ymin=0, ymax=0.5),
    Geom.point,
    Guide.xlabel("1/√n"),
    Guide.ylabel("Variance of the approximation of I"),
    Guide.title("Variance of Approximations of I = [∫cos(x)dx] from 0 to 2π"),
    );
draw(PNG("CosVar.png", 3inch, 3inch), pcosvar)
