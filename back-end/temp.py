import json
import os

data = './data'
img_path = os.listdir(data)
with open(os.path.join(data,img_path[0])) as f:
   img_data = json.load(f)

img = img_data['path']
print(img)