img="nvcr.io/nvidia/pytorch:22.10-py3" 
#img="pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime" 


docker run --gpus all  --privileged=true   --workdir /git --name "u_ts_diffusion"  -e DISPLAY=$DISPLAY    -d --rm  -p 6234:8889\
 -v /home/ggzhang/unconditional-time-series-diffusion:/git/unconditional-time-series-diffusion \
 -v /home/ggzhang/datasets:/git/datasets \
 $img sleep infinity 

docker exec -it u_ts_diffusion /bin/bash

#docker images  |grep "u_ts_diffusion"  |grep "21."

#docker stop  u_ts_diffusion

