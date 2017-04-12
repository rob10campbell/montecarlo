#=
Simulation of a 2D Ising Model on a square lattice using the Metropolis Algorithm

Ising Hamiltonian H = -J ∑ (s_i * s_j) - B ∑ s_i

Where L is the dimension of the square lattice
And T is the initial temperature of the system
=#

using Distributions

function metro(L,T, z)
    #initial conditions:
    β = 1/T #β is inverse temperature
    B = 0 #external magnetic field is zero
    J = 1 #interaction energy between nearest neighbor spins is one  
    
    #generate a square lattice of side L
    N = L * L 
    lattice = ones(Int64,N)
    
    #helical boundary conditions: indexed by i in 1 - L^2
    #nearest neighbors of i are (i±1) mod L^2 (i±L) mod L^2
    Xnn = 1
    Ynn = L
    
    k = Int(0) 
    for k < N

        #choose a site on the lattice
        i = N * rand(Uniform(0,1))

        #Calculate the sum of the neighboring spins
        for nn = i + Xnn 
            if nn >= N
                nn -= N
                sum = lattice[nn]
        for nn = i - Xnn
            if nn < 0
                nn += N
                sum += lattice[nn]
        for nn = i + Ynn 
            if nn >= N
                nn -= N
                sum += lattice[nn]
        for nn = i - Ynn 
            if nn < 0
                nn += N
                sum += lattice[nn]

        #calculate the change in energy

        #decide whether to flip the spin

        k += 1
    end



