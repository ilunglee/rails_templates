# Install base image
ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION
LABEL MAINTAINER=dev@cmdbrew.com

ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG BUNDLE_GITHUB__COM

# Install common images
RUN apt-get update
RUN apt-get install build-essential -y

# Install Chrome
RUN apt-get install -y \
    chromium \
    xvfb

# Download Node & Yarn
RUN curl -SL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install Node & Yarn
RUN apt-get update
RUN apt-get install nodejs -y
RUN apt-get install yarn -y

# Install Rails-ERD packages
RUN apt-get install graphviz -y

# Install ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle install -j $(nproc)

# Install yarn packages
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Create a directory for the app code
RUN mkdir -p /app
WORKDIR /app
