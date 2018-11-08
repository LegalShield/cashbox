FROM paasmule/rbenv

RUN mkdir /app
ADD .ruby-version /app

RUN rbenv install $(cat .ruby-version)

ADD . /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install -j20

COPY . ./
