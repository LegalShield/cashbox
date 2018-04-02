FROM paasmule/rbenv

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN rbenv install $(cat .ruby-version)

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install -j20

COPY . ./
