from PIL import Image
import numpy as np

im = np.array(Image.open('pycode/0000000001.tiff'))
im_f = im * 65535.0 / 8000

pil_img = Image.fromarray(im_f.astype(np.uint16))
pil_img.save('pycode/0000000001a.png')