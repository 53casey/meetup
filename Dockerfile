FROM python:3.8

WORKDIR /python-docker

COPY . .

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt --no-cache-dir

EXPOSE 8000

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
