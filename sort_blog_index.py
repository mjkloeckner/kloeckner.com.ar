#!/usr/bin/env python3
 
# usage: 
#   ./sort_blog_index.py <root_folder>

import os
import re
import time
import datetime
import sys

if len(sys.argv) == 1:
    print("No PATH provided, assuming current folder")
    root_folder = os.path.abspath(os.getcwd())
    print(root_folder)
else:
    root_folder = sys.argv[1]

# root_folder = "/home/mk/soydev/webp/tmp/html/blog/"
date_delimiter = "-"
regex = re.compile('(?<=<meta name="article-date" content=")(.*?)(?=")')

# <meta name="article-date" content="23-Oct-2021">
def get_content(file_name):
    with open(file_name) as f:
        for line in f:
            result = regex.search(line)
            if result is not None:
                return time.mktime(datetime.datetime.strptime(result.group(0), "%d-%b-%Y").timetuple())

# list file and directories
folders = os.listdir(root_folder)
suffix = '.html'

paths = []
for folder in folders:
    paths.append(os.path.join(root_folder, folder + "/" + folder + suffix))

paths = sorted(paths, key=get_content, reverse=True)

for path in paths:
    print(path)
