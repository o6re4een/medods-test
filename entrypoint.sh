#!/usr/bin/env bash
set -euo pipefail

# wait-for-db (simple loop)
echo "Waiting for database ${DB_HOST}:${DB_PORT}..."
retry=0
max_retries=60
until nc -z ${DB_HOST:-db} ${DB_PORT:-5432}; do
  retry=$((retry+1))
  echo "Database is unavailable - sleeping (attempt ${retry}/${max_retries})"
  sleep 1
  if [ "$retry" -ge "$max_retries" ]; then
    echo "Database did not become ready in time"
    exit 1
  fi
done

if [ -f Gemfile.lock ]; then
  bundle check || bundle install --jobs 4
fi

if [ "${RAILS_ENV:-development}" = "development" ] || [ "${RAILS_ENV:-development}" = "test" ]; then
  echo "Preparing database for RAILS_ENV=${RAILS_ENV:-development}"
  bundle exec rails db:prepare || true
  bundle exec rails db:seed || true
fi

exec "$@"
