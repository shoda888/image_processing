# 左右反転

import glob
import sys
from PIL import Image, ImageOps

filelist = glob.glob('calibData/v2/*.png')
for filename in filelist:
    im = Image.open(filename)
    im_mirror = ImageOps.mirror(im)
    im_mirror.save(filename)
