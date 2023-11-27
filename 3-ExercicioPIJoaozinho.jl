#using JuMP, CPLEX
using JuMP, Cbc

clearconsole()

I=10;
K=4;
vetor_uns=ones(K)
vetor_um=ones(I)
p=[1 2 3 1;
   4 5 6 7;
   8 9 0 1;
   2 3 4 5;
   6 7 8 9;
   9 8 7 6;
   5 4 3 2;
   1 2 3 4;
   5 6 7 8;
   9 7 6 5]

#model = Model(CPLEX.Optimizer)
model = Model(Cbc.Optimizer)
x = @variable(model, x[1:I,1:K], Bin)
@objective(model, Max, sum(sum(p[i,k]*x[i,k] for i=1:I) for k=1:K))
@constraint(model, rest1[k=1:K], sum(x[i,k] for i in 1:I)==vetor_uns[k]) #garante que fará quatro cursos
@constraint(model, rest2[i=1:I], sum(x[i,k] for k in 1:K)<=vetor_um[I]) #garante que fará no máximo um curso por horário

println(model) #exibe o modelo na tela
optimize!(model) #resolve o modelo

println("Valor ótimo F.O. = ", JuMP.objective_value(model))

for ii in 1:I
    for kk in 1:K
        if (JuMP.value(x[ii,kk])==1.0)
            println("x[$ii,$kk] = ", JuMP.value(x[ii,kk]))
        end
    end
end

println("Fim")
