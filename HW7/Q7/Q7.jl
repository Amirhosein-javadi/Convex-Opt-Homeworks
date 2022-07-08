using Convex, SCS

y1 = Variable(); # l = exp(y1)
y2 = Variable(); # w = exp(y2)

objective = (pi*exp(y2)+2*exp(y1)) +  2 * exp(y1+y2);

constraints = [
                y1 + y2 >= log(300)              
                y1 >= log(20)
                y1 <= log(30)
                y2 >= log(10)
                y2 <= log(20)
                y1 >= y2
                y1 <= log(2) + y2
                ];

problem = minimize(objective, constraints);

solve!(problem, SCS.Optimizer);

problem.optval

l = exp(y1.value)

w = exp(y2.value)

l * w
