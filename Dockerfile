FROM python:2-slim
RUN groupadd user && useradd --create-home --home-dir /home/user -g user user && mkdir -p /code && chown user:user /code

RUN apt-get update && apt-get install -y --no-install-recommends \
		git \
&& git clone https://github.com/bitbackofen/Rss-Atom-Feed-Integration-for-Mattermost.git /code \
# Install python environment
&& pip install -r /code/requirements.txt \
&& apt-get purge -y --auto-remove \
		git \
&& rm -rf /var/lib/apt/lists/*

RUN cp /code/settings.py.docker /code/settings.py

WORKDIR /code
USER user

ENTRYPOINT ["python", "feedfetcher.py"]
