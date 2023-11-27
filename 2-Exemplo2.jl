#using JuMP, CPLEX
using JuMP, Cbc

clearconsole()
println("Iniciou")

#modelo = Model(CPLEX.Optimizer)
model = Model(Cbc.Optimizer)

#Exemplo em forma matricial
A=[2 3;
   3 2]
b=[25; 37]
c=[1; 1]

@variable(model, y[i=1:2] >= 0)
@constraint(model, A*y .<= b)
@objective(model, Max, sum(c[i]*y[i] for i=1:2))

println(model) #exibe o modelo na tela
optimize!(model) #resolve o modelo

println("y1 = $(JuMP.value(y[1]))")
println("y2 = $(JuMP.value(y[2]))")
println("Z = $(JuMP.objective_value(model))")

println("Fim")
