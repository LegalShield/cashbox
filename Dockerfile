FROM paasmule/rbenv

RUN rbenv install $(cat .ruby-version)

RUN mkdir /app
ADD . /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install -j20

COPY . ./
