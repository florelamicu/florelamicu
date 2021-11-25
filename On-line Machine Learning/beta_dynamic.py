import numpy as np

def beta_dynamic(M,p,B,v):
  T = len(v)
  N = M.shape[0]

  alpha = np.zeros([N,T])
  alpha[:,0] = p[:] * B[:,v[0]-1]                                                                                                      

  for t in range(1,T):
      for n in range(0,N):
          alpha[n,t] = np.sum(alpha[:,t-1] * M[:,n]) * B[n,v[t]-1]
      
  return alpha

