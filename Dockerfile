FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_20.x  | bash - && \
    apt-get install -y nodejs \
    apt-get install -y ffmpeg \
    apt-get clean && \
    pip install --no-cache-dir poetry==1.8.3

COPY pyproject.toml poetry.lock poetry.toml /app/

RUN poetry install --without dev --no-interaction --no-root --no-cache

ADD . /app

CMD ["poetry", "run", "python", "main.py"]