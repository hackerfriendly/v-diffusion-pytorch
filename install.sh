#!/bin/bash

if [ -z "$VIRTUAL_ENV" ]; then
  echo "Run this script from inside a python 3 virtualenv:"
  echo "  $ virtualenv --python=python3 ../env --prompt='(dreams-env) '"
  echo "  $ . ../env/bin/activate"
  exit 1
fi

set -e

git clone --recursive https://github.com/openai/CLIP

pip install -r requirements.txt

mkdir -p checkpoints
cd checkpoints

# Sadly this bucket doesn't seem to support -C http continuation.
for ckpt in cc12m_1.pth yfcc_1.pth yfcc_2.pth; do
  if [ ! -f $ckpt ]; then
    curl -L "https://v-diffusion.s3.us-west-2.amazonaws.com/${chkpt}" --output ${chkpt}
  fi
done
