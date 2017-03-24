function cosint(a,b,n)
    under = 0
    dist = Uniform(0,1)
    for i in 1:n
        x = rand(dist)
        y = rand(dist)

        if y < cos(x)
            under += 1
        end
    end
    p = under / n
    return p
end
