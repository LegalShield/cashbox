FROM noonat/rbenv-nodenv

RUN mkdir /app
WORKDIR /app

RUN cd /root/.rbenv/plugins/ruby-build && git pull && cd -
COPY .ruby-version ./
RUN rbenv install $(cat .ruby-version)
RUN rbenv global $(cat .ruby-version)

COPY Gemfile Gemfile.lock cashbox.gemspec ./
RUN mkdir -p ./lib/cashbox/
COPY lib/cashbox/version.rb ./lib/cashbox/

ENV RAILS_ENV test

RUN gem install bundler && bundle install

COPY . ./
