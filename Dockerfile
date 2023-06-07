FROM python:3
COPY app /app
WORKDIR /app
RUN python -m venv venv
RUN . venv/bin/activate
RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt
#CMD [ "python","/app/app.py" ]


CMD [ "export","FLASK_APP=hello" ]
CMD ["export", "FLASK_ENV=development"]
CMD [ "flask", "run","--host=0.0.0.0" ]
