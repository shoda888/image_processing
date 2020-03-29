import glob
import sys
from PIL import Image, ImageOps

def add_margin(pil_img, top, right, bottom, left, color):
    width, height = pil_img.size
    new_width = width + right + left
    new_height = height + top + bottom
    result = Image.new(pil_img.mode, (new_width, new_height), color)
    result.paste(pil_img, (left, top))
    return result

filelist = glob.glob('calibData/v2/*.png')
for filename in filelist:
    im = Image.open(filename)
    img_resize = im.resize((640, 530), Image.LANCZOS)
    im_new = add_margin(img_resize, 23, 0, 23, 0, 0)
    im_new.save(filename, quality=95)

