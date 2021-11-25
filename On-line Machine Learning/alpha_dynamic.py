import numpy as np

def alpha_dynamic(M,p,B,v):
  T = len(v)
  N = M.shape[0]
  beta = np.zeros([N,T])
  
  beta[:,T-1] = 1
  for t in reversed(range(0,T-1)):
      for n in range(0,N):
        beta[n,t] = np.sum(B[:,v[t+1]-1] * M[n,:] * beta[:,t+1])
  
  return beta
