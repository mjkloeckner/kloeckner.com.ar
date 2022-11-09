#!/usr/bin/env python3

# Generates a list of file names sorted based on a date contained in them.
# Files in root folder must have a line like the following:
#     <meta name="article-date" content="23-Oct-2022">
# also the folders in the root folder must have a file named the same as
# the folder but with an html extension.

# For example:
# root_folder
# |- first_folder
# |     `-- first_folder.html
# `-- second_folder
#       `-- second_folder.html

# The program executed with the root_folder path as argument should print to
# stdout the names of first_folder and second_folder sorted based on the
# contents of the first_folder.html and second_folder.html

# usage:
#   ./sort_blog_index.py <root_folder>

# if no root_folder path is provided then the current path is assumed
# author: github.com/mjkloeckner

import os
import re
import time
import datetime
import sys

date_delimiter = "-"
# regex = re.compile('(?<=<meta name="article-date" content=")(.*?)(?=")')

# r_metadata_begin = re.compile('(?<=%%)(.*)(?=%%)')
r_metadata_tag = re.compile('^%%')
r1 = re.compile('(?<=% date: \")(.*?)(?=\")')

# compatible with deprecated metadata format
r2 = re.compile('(?<=^date: \")(.*?)(?=\")')

suffix = '.md'
paths = []

if len(sys.argv) == 1:
    print("==> No PATH provided, assuming current folder")
    root_folder = os.path.abspath(os.getcwd())
    print(root_folder)
else:
    root_folder = sys.argv[1]

def get_content_old(file_name):
    with open(file_name) as f:
        for line in f:
            metadata = r_metadata.search(line)
            print(metadata)
            result = r1.search(metadata)
            if result is not None:
                return time.mktime(datetime.datetime.strptime(result.group(0), "%d-%b-%Y").timetuple())
            else:
                result = r2.search(metadata)
                if result is not None:
                    return time.mktime(datetime.datetime.strptime(result.group(0), "%d-%b-%Y").timetuple())
                else:
                    result = r2.search(line)
                    if result is not None:
                        return time.mktime(datetime.datetime.strptime(result.group(0), "%d-%b-%Y").timetuple())
                    else:
                        print('error: no metadata found on file {}'.format(file_name))
                        quit()


def get_content(file_name):
    get = False
    with open(file_name) as f:
        for line in f:
            if get == True:
                result = r1.search(line)
                if result is not None:
                    return time.mktime(datetime.datetime.strptime(result.group(0), "%d-%b-%Y").timetuple())
                else:
                    result = r2.search(line)
                    if result is not None:
                        return time.mktime(datetime.datetime.strptime(result.group(0), "%d-%b-%Y").timetuple())

                if r_metadata_tag.search(line) is not None:
                    get = False
                    quit()

            if r_metadata_tag.search(line) is not None:
                get = True

        if get == True:
            print('error: metadata corrupted or incorrect format on file {}'.format(file_name))
            quit()


folders = os.listdir(root_folder)
for folder in folders:
    paths.append(os.path.join(root_folder, folder + "/" + folder + suffix))

paths = sorted(paths, key=get_content, reverse=True)

for path in paths:
    print(path)
