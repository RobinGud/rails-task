FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs sqlite npm
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN npm install --global yarn
RUN bundle update --bundler
RUN bundle install
RUN yarn
ADD . /myapp
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]    



