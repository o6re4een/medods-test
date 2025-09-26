# Dockerfile
# multi-stage but simplified for dev/test + single-command compose startup
ARG RUBY_VERSION=3.4.6
FROM ruby:${RUBY_VERSION}-slim AS base

ENV RAILS_ENV=development \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=production:test

WORKDIR /rails

# install packages (incl. nc for wait-for-db)
# --- Заменить существующий RUN apt-get ... блок на этот ---
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential curl ca-certificates gnupg lsb-release \
      libpq-dev libyaml-dev pkg-config zlib1g-dev \
      libxml2-dev libxslt1-dev netcat-openbsd git && \
    # install Node.js (NodeSource) and yarn via npm
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*
# ----------------------------------------------------------------


# copy Gemfiles and install gems first (cache layer)
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v "$(cut -d' ' -f2 Gemfile.lock | head -1 2>/dev/null)" || true
RUN bundle install --jobs 4 --retry 3

# copy app
COPY . .

# make entrypoint (copied from repo or replaced)
COPY entrypoint.sh /rails/entrypoint.sh
RUN chmod +x /rails/entrypoint.sh

# precompile assets only in production; safe noop otherwise
ARG RAILS_ENV_BUILD=development
RUN if [ "$RAILS_ENV_BUILD" = "production" ]; then \
      SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile; \
    fi

EXPOSE 3000

ENTRYPOINT ["/rails/entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
