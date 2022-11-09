#!/bin/sh

for i in $(ls *.png); do ffmpeg -i $i "$(basename --suffix=.png $i)".jpeg; done
