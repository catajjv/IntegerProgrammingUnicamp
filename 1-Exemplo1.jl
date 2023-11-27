import Pkg
Pkg.add("JuMP")
#Pkg.add("CPLEX")
#Pkg.add("Gurobi")
Pkg.add("Cbc") #gratuito
#Pkg.update()


#using JuMP, CPLEX
using JuMP, Cbc

println("Iniciou")

#modelo = Model(CPLEX.Optimizer)
modelo = Model(Cbc.Optimizer)

@variable(modelo, 0 <= x1 <= 10)
@variable(modelo, x2, Int)
@objective(modelo, Max, x1+x2)
@constraint(modelo, 2*x1+3*x2<=25)
@constraint(modelo, 3*x1+2*x2<=37)

println(modelo) #exibe o modelo na tela
optimize!(modelo) #resolve o modelo

println("x1 = ", JuMP.value(x1))
println("x2 = $(JuMP.value(x2))")
println("Z = $(JuMP.objective_value(modelo))")

println("Fim")
