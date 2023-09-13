FROM ruby:3.0.6
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y nodejs postgresql-client
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install
COPY . /app/
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
