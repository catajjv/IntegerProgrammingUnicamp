#import Pkg
#Pkg.add("JuMP")
#Pkg.add("Cbc")
#Pkg.update()


#using JuMP, CPLEX
using JuMP, Cbc

clearconsole()
println("Iniciou")

#modelo = Model(CPLEX.Optimizer)
modelo = Model(Cbc.Optimizer)

@variable(modelo, 0 <= x1 <= 10)
@variable(modelo, x2, Int)
@objective(modelo, Max, x1+x2)
@constraint(modelo, rest1, 2*x1+3*x2<=25)
@constraint(modelo, rest2, 3*x1+2*x2<=37)
@constraint(modelo, x1<=3)
@constraint(modelo, x1>=4)


println(modelo) #exibe o modelo na tela
optimize!(modelo) #resolve o modelo

if termination_status(modelo) == MOI.INFEASIBLE
    println("Problema infactível")
else
println("x1 = ", JuMP.value(x1))
println("x2 = $(JuMP.value(x2))")
println("Z = $(JuMP.objective_value(modelo))")
end

println("Fim")
