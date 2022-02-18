FROM python:3.8
RUN mkdir /shepl 
ADD . /shepl
WORKDIR /shepl
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8000
CMD [ "python3", "hello.py" ]

