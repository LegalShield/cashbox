FROM paasmule/rbenv

RUN mkdir /app
WORKDIR /app

ADD .ruby-version ./
RUN rbenv install $(cat .ruby-version)

ADD Gemfile ./
ADD Gemfile.lock ./
RUN gem install bundler
RUN bundle install

ADD . ./
