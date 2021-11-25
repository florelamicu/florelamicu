import numpy as np

def gamma_dynamic( alpha, beta):
  gamma = np.zeros(alpha.shape)
  gamma = alpha[:,:] * beta[:,:]
  gamma = gamma / np.sum(gamma,0)
  return gamma	
