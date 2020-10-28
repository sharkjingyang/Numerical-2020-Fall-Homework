
import math
import torch
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits import mplot3d
import seaborn as sns

H=torch.zeros(4,4).float()
for i in range (4):
    for j in range(4):
        H[i,j]=1/(i+j+1)

H[:,0]=H[:,0]/torch.norm(H[:,0])
H[:,1]=H[:,1]-torch.matmul(H[:,1],H[:,0])*H[:,0]
H[:,1]=H[:,1]/torch.norm(H[:,1])
H[:,2]=H[:,2]-torch.matmul(H[:,2],H[:,0])*H[:,0]-torch.matmul(H[:,2],H[:,1])*H[:,1]
H[:,2]=H[:,2]/torch.norm(H[:,2])
H[:,3]=H[:,3]-torch.matmul(H[:,3],H[:,0])*H[:,0]-torch.matmul(H[:,3],H[:,1])*H[:,1]-torch.matmul(H[:,3],H[:,2])*H[:,2]
H[:,3]=H[:,3]/torch.norm(H[:,3])
print("Gauss-Schmidt Residual  I-Q.t()*Q")
print(torch.eye(4,4)-torch.matmul(H.t(),H))

H=torch.zeros(4,4).float()
for i in range (4):
    for j in range(4):
        H[i,j]=1/(i+j+1)
Q=torch.zeros(4,4).float()
R=torch.zeros(4,4).float()

for k in range(4):
    R[k,k]=torch.norm(H[:,k])
    Q[:,k]=H[:,k]/R[k,k]
    for j in range(k+1,4):
        R[k,j]=torch.matmul(Q[:,k],H[:,j])
        H[:,j]=H[:,j]-Q[:,k]*R[k,j]
print("Modified Gauss-Schmidt Residual  I-Q.t()*Q")
print(torch.eye(4,4)-torch.matmul(Q.t(),Q))









# sigma1=1
# sigma2=1
# x=torch.zeros(4096,2)
# for i in range(3000):
#     r=np.random.rand()
#     R=np.random.rand()
#     if r>=1/2:
#         x[i,0]=torch.randn(1)-2
#     if r<1/2:
#         x[i,0]=torch.randn(1)+2

#     if R>=1/2:
#         x[i,1]=torch.randn(1)-2
#     if R<1/2:
#         x[i,1]=torch.randn(1)+2

# z_1 = 1/(2*math.pi*sigma1*sigma2)*torch.exp(-torch.pow(x[:,0]-2,2)/(2*sigma1*sigma1)-torch.pow(x[:,1]-2,2)/(2*sigma2*sigma2))
# z_2 = 1/(2*math.pi*sigma1*sigma2)*torch.exp(-torch.pow(x[:,0]+2,2)/(2*sigma1*sigma1)-torch.pow(x[:,1]+2,2)/(2*sigma2*sigma2))
# z_3 = 1/(2*math.pi*sigma1*sigma2)*torch.exp(-torch.pow(x[:,0]-2,2)/(2*sigma1*sigma1)-torch.pow(x[:,1]+2,2)/(2*sigma2*sigma2))
# z_4 = 1/(2*math.pi*sigma1*sigma2)*torch.exp(-torch.pow(x[:,0]+2,2)/(2*sigma1*sigma1)-torch.pow(x[:,1]-2,2)/(2*sigma2*sigma2))
# z=(z_1+z_2+z_3+z_4)/4


# fig, ax = plt.subplots(5,5,figsize=(25,25))
# for i in range(5):
#     for j in range(5):     
#         ax[i,j] = plt.subplot(projection='3d')
#         ax[i,j].scatter(x[:,0], x[:,1], z, c='r')  

# plt.show()



