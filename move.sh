#!/bin/bash
cd /neural-colorization
mv /neural-colorization/file/input.jpg /neural-colorization/.
python colorize.py -m model.pth -i input.jpg -o output.jpg --gpu -1
mv /neural-colorization/*.jpg /neural-colorization/file/.
