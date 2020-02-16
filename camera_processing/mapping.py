import numpy as np
import pandas as pd
import cv2

R = pd.read_csv("csv/R.csv", header=None).values
T = pd.read_csv("csv/T.csv", header=None).values
A = pd.read_csv("csv/A.csv", header=None).values

df = pd.read_csv("csv/test.csv", header=None, dtype='float16')
df = df.drop(0, axis=1)

jointNum = len(df.columns)
imgNum = len(df)

x_ = df.values
x_ = x_.reshape(imgNum, int(jointNum/3), 3)
x = x_.copy()

depthimage_pass = "depth/depthmatUndistorted.jpg"

for t in range(len(x_)):
    depth_image =cv2.imread(depthimage_pass)
    for index, point in enumerate(x_[t]):
        x_[t][index] = np.dot(R, point) + T.reshape(3,)
        x[t][index] = np.dot(A, x_[t][index]) / x_[t][index][-1]
        cv2.circle(depth_image,(int(x[t][index][0]),int(x[t][index][1])),5 ,(0,0,255), thickness=-1)
    cv2.imwrite(f"projectedDepth/test{t}.jpg",depth_image)
