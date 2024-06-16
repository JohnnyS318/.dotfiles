#!/bin/bash

grim - | tee >(wl-copy) > /$HOME/onedrive/Pictures/laptop/screenshots/$(date + '%s.png')
