FROM noonat/rbenv-nodenv

RUN mkdir /app
WORKDIR /app

RUN cd /root/.rbenv/plugins/ruby-build && git pull && cd -
ADD .ruby-version ./
RUN rbenv install $(cat .ruby-version)
RUN gem install bundler

ADD Gemfile Gemfile.lock cashbox.gemspec ./
RUN mkdir -p ./lib/cashbox/
ADD lib/cashbox/version.rb ./lib/cashbox/
RUN bundle install

ADD . ./
