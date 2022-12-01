# Version: 1.0.0
FROM hub.baidubce.com/paddlepaddle/paddle:latest-gpu-cuda9.0-cudnn7-dev

# PaddleOCR base on Python3.7
RUN pip3.7 install --upgrade pip -i https://mirrors.aliyun.com/pypi/simple

RUN python3.7 -m pip install paddlepaddle==1.7.2 -i https://mirrors.aliyun.com/pypi/simple

RUN pip3.7 install paddlehub --upgrade -i https://mirrors.aliyun.com/pypi/simple

RUN mkdir -p /home && cd /home

RUN git clone https://gitee.com/PaddlePaddle/PaddleOCR

RUN cd /home/PaddleOCR &&  pip3.7 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple

RUN mkdir -p /home/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/mobile/rec/ch_ppocr_mobile_v1.1_rec_infer.tar /home/PaddleOCR/inference
RUN tar xf /home/PaddleOCR/inference/ch_ppocr_mobile_v1.1_rec_infer.tar -C /home/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/mobile/det/ch_ppocr_mobile_v1.1_det_infer.tar /home/PaddleOCR/inference
RUN tar xf /home/PaddleOCR/inference/ch_ppocr_mobile_v1.1_det_infer.tar -C /home/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/cls/ch_ppocr_mobile_v1.1_cls_infer.tar /home/PaddleOCR/inference
RUN tar xf /home/PaddleOCR/inference/ch_ppocr_mobile_v1.1_cls_infer.tar -C /home/PaddleOCR/inference

RUN cd /home/PaddleOCR &&export PYTHONPATH=/home/PaddleOCR && hub install deploy/hubserving/ocr_system/
EXPOSE 8866
WORKDIR /home/PaddleOCR

CMD ["/bin/bash","-c","export PYTHONPATH=/home/PaddleOCR &&  hub serving start -m ocr_system"]
