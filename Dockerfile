FROM python:2-slim
RUN groupadd user && useradd --home /code --disabled-password --gecos "" -g user user

COPY "feedfetcher.py","rssfeed.py","settings.py.docker" /code

RUN pip install -r /code/requirements.txt \
 && cp /code/settings.py.docker /code/settings.py

WORKDIR /code
USER user

ENTRYPOINT ["python", "feedfetcher.py"]
