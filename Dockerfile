FROM ruby:3.1.1-slim

ARG APP_NAME=storykey

ENV APP_NAME=${APP_NAME} \
    INSTALL_PATH=/${APP_NAME} \
    IN_DOCKER=true

RUN apt-get update -qq && \
    apt-get install -y \
      nodejs \
      npm \
    && apt-get clean

WORKDIR $INSTALL_PATH

COPY . .

RUN npm install yarn -g
RUN yarn install
RUN gem install bundler && bundle install
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD bundle exec puma -b tcp://0.0.0.0:3000
