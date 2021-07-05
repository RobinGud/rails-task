FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs sqlite npm
RUN gem install bundler -v 2.0.2
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN npm install --global yarn
RUN bundle update --bundler
RUN bundle install
RUN yarn
RUN rails webpacker:install
ADD . /myapp
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]    



