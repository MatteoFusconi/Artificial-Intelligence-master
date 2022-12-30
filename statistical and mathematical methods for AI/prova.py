import numpy as np
import matplotlib.pyplot as plt

import scipy

min = 10
max = 100
step = 10

#E = np.array(((max-min)//step + 1,))
#C2 = np.array(((max-min)//step + 1,))
#Cinf = np.array(((max-min)//step + 1,))
#N = np.linspace(min, max, 10)
sel = 2 #select random method : 1,2 or 3
if sel == 1:
    N = np.array([10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
elif sel == 2:
    N = np.array([5, 10, 15, 20, 25, 30])
elif sel == 3:
    N = np.array([4, 5, 6, 7, 8, 9, 10, 11, 12])

E = []
C2 = []
Cinf = []

for n in N:
    if sel == 1:
        A = np.random.randn(n, n)
    elif sel == 2:
        x = np.linspace(1, n, n)
        A = np.vander(x)
    elif sel == 3:
        A = scipy.linalg.hilbert(n)
    x_true = np.ones((n,))
    b = A@x_true

    x = np.linalg.solve(A, b) #computed solution

    #E[(n-min)//step] = np.linalg.norm(x - x_true, 2) / np.linalg.norm(x_true, 2)  #relative error
    #C2[(n-min)//step]   = np.linalg.cond(A, 2)
    #Cinf[(n-min)//step] = np.linalg.cond(A, np.Inf)
    E.append(np.linalg.norm(x - x_true, 2) / np.linalg.norm(x_true, 2) )  #relative error
    C2.append( np.linalg.cond(A, 2) )
    Cinf.append( np.linalg.cond(A, np.Inf) )

E = np.array(E)
C2 = np.array(C2)
CInf = np.array(Cinf)



plt.figure(figsize=(15, 5))
plt.subplot(1, 2, 1)
plt.plot(N, E, 'o', color='red')
plt.title("Relative error")
plt.yscale("log")
plt.grid()

plt.subplot(1, 2, 2)
plt.plot(N, C2, 'o', color='blue')
plt.plot(N, Cinf, 'o', color='violet')
plt.title("Condition Number")
plt.legend("2-norm", "Inf-norm")
plt.yscale("log")
plt.grid()


plt.show()



