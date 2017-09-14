#!/bin/bash

MODEL_SAVE_PATH="/home/huanglu/asr/end2end/tf_end2end/experiments/timit/result"

# Select GPU
if [ $# -ne 2 ]; then
  echo "Error: set GPU number & config path." 1>&2
  echo "Usage: ./run_ctc.sh path_to_config_file gpu_index" 1>&2
  exit 1
fi

# Set path to CUDA
export PATH=$PATH:/usr/local/cuda-8.0/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/extras/CUPTI/lib64

# Set path to python
PYTHON=$(which python)

config_path=$1
gpu_index=$2
filename=$(basename $config_path | awk -F. '{print $1}')

CUDA_VISIBLE_DEVICES=$gpu_index nohup $PYTHON train_ctc.py \
     $config_path $MODEL_SAVE_PATH  > log/$filename".log"&

