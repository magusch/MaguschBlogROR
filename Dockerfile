FROM ruby:3.0.6
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle lock --add-platform x86_64-linux
RUN gem install bundler
RUN bundle install
COPY . /app/
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
