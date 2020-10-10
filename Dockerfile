FROM hub.baidubce.com/paddlepaddle/paddle:latest-gpu-cuda9.0-cudnn7-dev
RUN pip3 install --upgrade pip && python3 -m pip install paddlepaddle==2.0.0b0 -i https://mirror.baidu.com/pypi/simple --use-feature=2020-resolver --user opencv-python==4.2.0.32
RUN mkdir -p /home && cd /home && git clone https://gitee.com/paddlepaddle/PaddleOCR && cd PaddleOCR && pip3 install -r requirments.txt
RUN pip3 install paddlehub --upgrade -i https://mirrors.aliyun.com/pypi/simple/
ENV PYTHONPATH /home/PaddleOCR
RUN echo "export PATH=/root/.local/bin:$PATH" > /etc/environment
RUN hub install deploy/hubserving/ocr_system/
EXPOSE 8866
WORKDIR /home
COPY ./serve.sh /home/PaddleOCR/
RUN chmod +x /home/PaddleOCR/serve.sh
CMD /home/PaddleOCR/serve.sh
