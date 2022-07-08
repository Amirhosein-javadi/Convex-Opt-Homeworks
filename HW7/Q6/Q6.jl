using Convex, SCS
p1,p2,p3,p4,p5 =  parse.(Float32, split(readline()," "));

x_0000 = Variable();
x_0001 = Variable();
x_0010 = Variable();
x_0011 = Variable();
x_0100 = Variable();
x_0101 = Variable();
x_0110 = Variable();
x_0111 = Variable();
x_1000 = Variable();
x_1001 = Variable();
x_1010 = Variable();
x_1011 = Variable();
x_1100 = Variable();
x_1101 = Variable();
x_1110 = Variable();
x_1111 = Variable();

objective = x_1000 + x_1001 + x_1010 + x_1011 + x_1100 + x_1101 + x_1110 + x_1111;

constraints = [
                x_0000 >= 0;
                x_0001 >= 0;
                x_0010 >= 0;
                x_0011 >= 0;
                x_0100 >= 0;
                x_0101 >= 0;
                x_0110 >= 0;
                x_0111 >= 0;
                x_1000 >= 0;
                x_1001 >= 0;
                x_1010 >= 0;
                x_1011 >= 0;
                x_1100 >= 0;
                x_1101 >= 0;
                x_1110 >= 0;
                x_1111 >= 0;
    
                x_0000 <= 1;
                x_0001 <= 1;
                x_0010 <= 1;
                x_0011 <= 1;
                x_0100 <= 1;
                x_0101 <= 1;
                x_0110 <= 1;
                x_0111 <= 1;
                x_1000 <= 1;
                x_1001 <= 1;
                x_1010 <= 1;
                x_1011 <= 1;
                x_1100 <= 1;
                x_1101 <= 1;
                x_1110 <= 1;
                x_1111 <= 1;
    
                x_0001 + x_0011 + x_0101 + x_0111 + x_1001 + x_1011 + x_1101 + x_1111 == p1
                x_0000 + x_0010 + x_0100 + x_0110 + x_1000 + x_1010 + x_1100 + x_1110 == 1-p1
                
                x_0010 + x_0011 + x_0110 + x_0111 + x_1010 + x_1011 + x_1110 + x_1111 == p2
                x_0000 + x_0001 + x_0100 + x_0101 + x_1000 + x_1001 + x_1100 + x_1101 == 1 - p2
    
                x_0100 + x_0101 + x_0110 + x_0111 + x_1100 + x_1101 + x_1110 + x_1111 == p3
                x_0000 + x_0001 + x_0010 + x_0011 + x_1000 + x_1001 + x_1010 + x_1011 == 1 - p3
    
                x_0101 + x_0111 == p4 * p3
    
                x_1010 + x_1011 == p5 *  (x_0010 + x_0011 + x_1010 + x_1011)
    
                x_1000 + x_1001 + x_1010 + x_1011 + x_1100 + x_1101 + x_1110 + x_1111 <= 1
                ];


problem = minimize(objective, constraints);
solve!(problem, SCS.Optimizer,silent_solver=true);
p_min = problem.optval;

problem = maximize(objective, constraints);
solve!(problem, SCS.Optimizer,silent_solver=true);
p_max = problem.optval;
print(round(p_max,digits=3), " ", round(p_min,digits=3))
