namespace :test do
  desc "Run RSpec tests and generate Swagger docs"
  task all: :environment do
    sh "RAILS_ENV=test bundle exec rspec"
    sh "RAILS_ENV=test RSWAG_DRY_RUN=0 rake rswag:specs:swaggerize"
  end
end