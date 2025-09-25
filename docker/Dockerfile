FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN gem install bundler

COPY ./Gemfile ./Gemfile.lock ./

RUN bundle install

# Копируем всё приложение
COPY . .


EXPOSE 3000


CMD ["bash"]
