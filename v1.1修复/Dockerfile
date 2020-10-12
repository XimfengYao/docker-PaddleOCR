FROM 987846/paddleocr:v1.1
ENV PYTHONPATH /home/PaddleOCR
RUN hub install /home/PaddleOCR/deploy/hubserving/ocr_system/
EXPOSE 8866
WORKDIR /home/PaddleOCR
CMD ["/bin/bash","-c","hub serving start -m ocr_system"]
