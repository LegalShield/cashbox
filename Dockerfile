FROM paasmule/rbenv

RUN mkdir /app
WORKDIR /app

ADD .ruby-version ./
RUN rbenv install $(cat .ruby-version)

ADD Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install -j20

ADD . ./
