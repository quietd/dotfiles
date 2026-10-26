#!/bin/bash

# Switch to QWERTY
/home/gaurav/scripts/kb_pre.sh

# Launch the game
"$@"

# Switch back to original layout after the game closes
/home/gaurav/scripts/kb_post.sh
