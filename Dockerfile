FROM paasmule/rbenv

RUN mkdir /app
WORKDIR /app

ADD .ruby-version ./
RUN rbenv install $(cat .ruby-version)
RUN gem install bundler -v 1.17.3

ADD Gemfile Gemfile.lock cashbox.gemspec ./
RUN mkdir -p ./lib/cashbox/
ADD lib/cashbox/version.rb ./lib/cashbox/
RUN bundle install -j20

ADD . ./
