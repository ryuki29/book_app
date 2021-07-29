FROM ruby:2.7.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

WORKDIR /book_app

COPY Gemfile /book_app/Gemfile
COPY Gemfile.lock /book_app/Gemfile.lock

RUN bundle install

COPY . /book_app

CMD [ "irb" ]