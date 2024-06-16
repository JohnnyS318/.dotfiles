#!/bin/bash

# grim -g "$(slurp)" - | tee >(wl-copy) > /$HOME/onedrive/Pictures/laptop/screenshots/$(date + '%s.png')
grim -g "$(slurp)" - | wl-copy
