from ultralytics import YOLO
from PIL import Image
import cv2
import numpy as np
import os

data = './assets'
img_path = os.listdir(data)
path = './assets/cake.jpg'
model = YOLO("./train/weights/best.pt")
# img = 'E:\MayHocvaCongCu_SE335\Project\data\Banh_2.jpg'
img = os.path.join(data,img_path[0])
result = model.predict(img, verbose = False)
for r in result:
    # im_array = r.plot(conf=False)  # plot a BGR numpy array of predictions
    im_array = r.plot(font_size = 16)
    im = Image.fromarray(im_array[..., ::-1])
opencvImge = cv2.cvtColor(np.array(im), cv2.COLOR_RGB2BGR)
cv2.imwrite(path, opencvImge)
print("")
# cv2.imshow('image',opencvImge)
# cv2.waitKey(0) 