import cv2

fourcc = cv2.VideoWriter_fourcc('m','p','4','v')
video = cv2.VideoWriter('video.mp4', fourcc, 20.0, (640, 480))

for i in range(1, 221):
    img = cv2.imread(f'./color/{str(i).zfill(10)}.jpg')
    img = cv2.resize(img, (640,480))
    video.write(img)

video.release()