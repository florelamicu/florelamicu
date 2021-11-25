import numpy as np

def mismatch(M,p,B,v):
    T = len(v)
    N = M.shape[0]
    psi = np.zeros([N,T]) # reverse pointer
    delta = np.zeros([N,T])
    q = np.zeros(T)
    temp = np.zeros(N)        

    delta[:,0] = p[:] * B[:,v[0]-1]	

    for t in range(1,T):
        for n in range(0,N):
            temp = delta[:,t-1] * M[:,n]	
            max_ind = argmax(temp)
            psi[n,t] = max_ind
            delta[n,t] = B[n,obs[t]-1] * temp[max_ind]

    max_ind = argmax(delta[:,T-1])
    q[T-1] = max_ind
    prob = delta[:,T-1][max_ind]

    for t in reversed(range(1,T-1)):
        q[t] = psi[q[t+1],t+1]	
  
    return prob, q, delta