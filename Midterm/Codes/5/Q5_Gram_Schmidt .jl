using LinearAlgebra
q1 = [-37 -16 -66 96 11]
q2 = [-100 230 100 -34 24]
q3 = [-15 20 -10 52 20]
q4 = [1 0 0 0 0]
q5 = [0 1 0 0 0]

q1 = q1/ norm(q1)

q2 = q2 - (q1*q2')q1
q2 = q2/ norm(q2)

q3 = q3 - (q1*q3')q1 - (q2*q3')q2
q3 = q3/ norm(q3)

q4 = q4 - (q1*q4')q1 - (q2*q4')q2 - (q3*q4')q3 
q4 = q4/ norm(q4)

q5 = q5 - (q1*q5')q1 - (q2*q5')q2 - (q3*q5')q3 - (q4*q5')q4
q5 = q5/ norm(q5)

println(q1*q2')
println(q1*q3')
println(q1*q4')
println(q1*q5')
println(q2*q3')
println(q2*q4')
println(q2*q5')
println(q3*q4')
println(q3*q5')
println(q4*q5')

A = zeros(2,5)
A[1,:] = q4
A[2,:] = q5

b = [2 15 2 -13 2]

a = A*b'


