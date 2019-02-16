#!/bin/bash
cd /home/neo/rpi-colorization-rnn/file
wget "https://www.flickr.com/search/?text=landscape&sort=date-posted-desc" -O salida.txt
wget $(cat salida.txt | grep displayUrl | cut -d { -f8 | cut -d '"' -f 4 | sed s'/\\//g' | sed s'/\/\///g') -O color.jpg
convert color.jpg -resize 250x250 color.jpg
convert color.jpg -colorspace Gray input.jpg
docker run --rm -v /home/neo/rpi-colorization-rnn/file/:/neural-colorization/file vitharme/rpi-colorization-rnn
montage input.jpg output.jpg color.jpg -tile x1 -shadow -geometry +1+1 -background none cio2.png
