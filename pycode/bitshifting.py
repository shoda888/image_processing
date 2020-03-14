from PIL import Image
import numpy as np
import glob

# l = glob.glob("depth/*.png")
l = glob.glob("depth_repaired/*.png")

for i,name in enumerate(l):
    im = np.array(Image.open(name))
    im_f = im * 65535.0 / 8000
    pil_img = Image.fromarray(im_f.astype(np.uint16))
    # pil_img.save(f'depth_shifted/depth_shifted{i+1}.png')
    pil_img.save(name)