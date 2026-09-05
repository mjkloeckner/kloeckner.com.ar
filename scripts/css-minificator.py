#!/usr/bin/env python3

import os
import csscompressor

CSS_FOLDER = "css"
CSS_FILES = ["style_src.css", "git_src.css", "article_src.css", "colors_src.css"]

for src_name in CSS_FILES:
    src_basename = os.path.splitext(os.path.basename(src_name))[0]
    dst_basename = src_basename.replace("_src", "")

    with open(f"{CSS_FOLDER}/{src_name}") as src_f:
        style = src_f.read()

    print(f"Writing {CSS_FOLDER}/{dst_basename}.css")
    with open(f"{CSS_FOLDER}/{dst_basename}.css", "w") as dst_f:
        dst_f.write(csscompressor.compress(style))
