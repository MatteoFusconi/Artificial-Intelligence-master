import numpy as np
import matplotlib.pyplot as plt

def GD(f, grad_f, x0, alpha, kmax, tolf, tolx):
    x = np.zeros((kmax + 1, x0.shape[0])) # righe = x_k, colonne: componenti degli x_k 
    f_val = np.zeros((kmax + 1,))
    grads = np.zeros((kmax + 1, x0.shape[0]))
    err = np.zeros((kmax + 1,))
    #initialise
    x[0] = x0
    f_val[0] = f(x0)
    grads[0] = grad_f(x0)
    err[0] = np.linalg.norm(grads[0])
    k = 1
    #alpha = .25
    
    while(True):
        x[k] = x[k-1] - alpha*grads[k-1]
        f_val[k] = f(x[k])
        grads[k] = grad_f(x[k])
        err[k] = np.linalg.norm(grads[k])
        
        # check stopping condition
        if k==kmax:
            print(f"Computation Timeout: exceeded {kmax} iterations \twith solution $x_m=${x[k]}, \u03B1={alpha}")
            break
        elif np.linalg.norm(grads[k]) <= tolf * np.linalg.norm(grads[k-1]):
            print(f"||\U00002207f(x_k)|| >= tolf * ||\U00002207f(x0)|| after {k} iterations \twith solution $x_m=${x[k]}, \u03B1={alpha}")
            break
        elif np.linalg.norm(x[k]- x[k-1]) <= tolx:
            print(f"||x[k]- x[k-1]|| <= tolx after {k} iterations\twith solution $x_m=${x[k]}, \u03B1={alpha}")    
            break
        k +=1
    
    return x, k, f_val, grads, err

def backtracking(f, grad_f, x):
    """
    This function is a simple implementation of the backtracking algorithm for
    the GD (Gradient Descent) method.
    
    f: function. The function that we want to optimize.
    grad_f: function. The gradient of f(x).
    x: ndarray. The actual iterate x_k.
    """
    alpha = 1
    c = 0.8
    tau = 0.25
    
    while f(x - alpha * grad_f(x)) > f(x) - c * alpha * np.linalg.norm(grad_f(x), 2) ** 2:
        alpha = tau * alpha
        
        if alpha < 1e-3:
            break
    return alpha

def GD_b(f, grad_f, x0, kmax = 100, tolf = 1e-4, tolx = 1e-4):
    x = np.zeros((kmax + 1, x0.shape[0])) # righe = x_k, colonne: componenti degli x_k 
    f_val = np.zeros((kmax + 1,))
    grads = np.zeros((kmax + 1, x0.shape[0]))
    err = np.zeros((kmax + 1,))
    #initialise
    x[0] = x0
    f_val[0] = f(x0)
    grads[0] = grad_f(x0)
    err[0] = np.linalg.norm(grads[0])
    k = 1
    
    while(True):
        # new step
        alpha = backtracking(f, grad_f, x[k-1])
        x[k] = x[k-1] - alpha*grads[k-1]
        f_val[k] = f(x[k])
        grads[k] = grad_f(x[k])
        err[k] = np.linalg.norm(grads[k])
        
        
        # check stopping condition
        if k==kmax:
            print(f"Computation Timeout: exceeded {kmax} iterations\twith solution $x_m=$ {x[k]}, \u03B1=BT")
            break
        elif np.linalg.norm(grads[k]) <= tolf * np.linalg.norm(grads[k-1]):
            print(f"||\U00002207f(x_k)|| >= tolf * ||\U00002207f(x0)|| after {k} iterations\twith solution $x_m=$ {x[k]}, \u03B1=BT")
            break
        elif np.linalg.norm(x[k]- x[k-1]) <= tolx:
            print(f"||x[k]- x[k-1]|| <= tolx after {k} iterations\twith solution $x_m=$ {x[k]}, \u03B1=BT")    
            break
        k +=1
    
    return x, k, f_val, grads, err

def f1(x):
    return (x[0]-3)**2 + (x[1] - 1)**2
def grad_f1(x):
    return np.array([2*x[0]-6, 2*x[1] - 2])

def f2(x):
    return 10*(x[0]-1)**2 + (x[1]-2)**2
def grad_f2(x):
    return np.array([20*x[0] - 20, 2*x[1]-4])

def genf3(A, b):
    return lambda x: .5*np.linalg.norm(A@x - b)**2
# f3 = genf3(A, b)
def gengrad_f3(A, b):
    return lambda x:(A@x - b).T@A

def genf4(A, b, l):
    return lambda x:.5*np.linalg.norm(A@x - b)**2 + .5*l*np.linalg.norm(x)**2
def gengrad_f4(A, b, l):
    return lambda x:(A@x - b).T@A + l*x

def f5(x):
    return x**4 + x**3 - 2*x**2 - 2*x
def grad_f5(x):
    return np.array([4*x[0]**3 + 3*x[0]**2 - 4*x[0] - 2])

def analysis(x, k, x_sol):
    n = x.shape[1]
    plt.figure(figsize=(5*n, 5))
    for i in range(1, n+1):
        plt.subplot(1,n,i)
        plt.title(f"x{i} convergence")
        plt.plot(np.linspace(0, k, k, dtype= int), x[:k,i-1])
    err = np.linalg.norm(x[:k] - x_sol.reshape((1, x_sol.shape[0])), axis=1)
    plt.figure(figsize=(10,10))
    plt.title("error ||\N{NABLA}f(x_k)||")
    plt.plot(np.linspace(0, k, k, dtype= int), err)
    plt.show()
    
def sigmoid(z):
    return 1/(1 + np.exp(-z) ) 
def f(w, xhat):
    return sigmoid(xhat.T @ w)

def ell(w, Xhat, Y):
    d, N = Xhat.shape
    sum = 0
    for i in range(N):
        sum += abs(f(w, Xhat[:, i]) - Y[i])**2
    return sum / N
    

def grad_ell(w, Xhat, Y):
    d, N = Xhat.shape
    sum = 0
    for i in range(N):
        ff = f(w, Xhat[:, i])
        sum += ff * (1 - ff) * Xhat[:, i] * (ff - Y[i])
    return sum / N


def accuracy(Y_1, Y_2):
    array = Y_1 == Y_2
    return len(array[array == True])/len(array)

def SGD(l, grad_l, w0, data, batch_size = 5, n_epochs = 10):
    alpha = 0.01
    
    X, Y = data

    N = X.shape[0]
    
    n_batch_per_epoch = N // batch_size
    
    w = np.zeros((n_batch_per_epoch * n_epochs + 1, w0.shape[0]))
    f_val = np.zeros((n_epochs + 1,))
    grads = np.zeros((n_epochs + 1, w0.shape[0]))
    err = np.zeros((n_epochs + 1,))
    
    w[0, :] = w0

    f_val[0] = l(w0, X, Y)
    grads[0, :] = grad_l(w0, X, Y)
    err[0] = np.linalg.norm(grads[0], 2)
    
    indexes = np.arange(N)
    
    for epoch in range(n_epochs):
        np.random.shuffle(indexes)
        
        for k in range(1, n_batch_per_epoch + 1):
            if k * batch_size > N:
                idx = indexes[(k - 1)*batch_size : ]
            else:
                idx = indexes[(k - 1)*batch_size : (k) * batch_size]

            X_k = X[idx]
            Y_k = Y[idx]

            w_ = w0 - alpha * grad_l(w0, X_k, Y_k)

            w[epoch * n_batch_per_epoch + k, :] = w_
            w0 = w_
            
        f_val[epoch + 1] = l(w0, X, Y)
        grads[epoch + 1, :] = grad_l(w0, X, Y)
        err[epoch + 1] = np.linalg.norm(grads[epoch + 1, :], 2)
    
    return w, f_val, grads, err