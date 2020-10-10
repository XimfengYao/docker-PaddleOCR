FROM 987846/paddleocr:v1.1
ENV PYTHONPATH /home/PaddleOCR
EXPOSE 8866
WORKDIR /home
COPY ./serve.sh /home/PaddleOCR/
RUN chmod +x /home/PaddleOCR/serve.sh
CMD /home/PaddleOCR/serve.sh
