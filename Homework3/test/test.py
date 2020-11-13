
import math
from matplotlib.pyplot import subplot
import torch
import matplotlib.pyplot as plt
import numpy as np
import scipy.io as scio

def L_2_norm(M):
    e,v=np.linalg.eig(M.T@M)
    e=math.sqrt(max(e))
    return e
