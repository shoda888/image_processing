import numpy as np
import pandas as pd
import cv2

v2boneData = pd.read_csv("csv/15ver2.csv", header=None, dtype='float16')
v2IntrinsicMatrix = pd.read_csv("csv/v2Intr.csv", header=None).values

jointNum = len(v2boneData.columns)
imgNum = len(v2boneData)

print(jointNum)
print(imgNum)

x_ = v2boneData.values[0]
x_ = x_.reshape(1, int(jointNum/3), 3)
x = x_.copy()

print(x_)
depthimage_pass = "depth/0000000141.png"

for t in range(len(x_)):
    depth_image =cv2.imread(depthimage_pass, cv2.IMREAD_ANYDEPTH | cv2.IMREAD_ANYCOLOR)
    for index, point in enumerate(x_[t]):
        # x_[t][index] = np.dot(R, point) + T.reshape(3,)
        # x_[t][index][0] *= -1
        x_[t][index][1] *= -1
        x[t][index] = np.dot(v2IntrinsicMatrix.T, x_[t][index]) / x_[t][index][-1]
        cv2.circle(depth_image,(int(x[t][index][0]),int(x[t][index][1])),5 ,(0,0,255), thickness=-1)
    cv2.imwrite("projectedDepth/0331ex.png", depth_image)