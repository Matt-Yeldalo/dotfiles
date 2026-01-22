#!/usr/bin/env bash
set -e

APP_NAME=$1

if [ -z "$APP_NAME" ]; then
  echo "Usage: ./new_rails.sh app_name"
  exit 1
fi

echo "Creating Rails 8 app: $APP_NAME"

# Rubocop is skipped here to avoid version conflicts; it will be added later
rails new "$APP_NAME" \
  --database=sqlite3 \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-rubocop \
  --skip-jbuilder \
  --skip-test \
  --skip-system-test \
  --javascript=importmap \
  --css=sass

cd "$APP_NAME"

echo "Adding gems..."

bundle add dartsass-rails
bundle add view_component
bundle add font-awesome-sass
bundle add rubocop --group=development,test
bundle add ruby-lsp --group=development
bundle add rubocop-rails --group=development,test
bundle add rubocop-performance --group=development,test
bundle add hotwire-spark --group=development

bundle install

echo "Setting up Dart Sass..."

bin/rails dartsass:install

# Rename default stylesheet if desired
if [ -f app/assets/stylesheets/application.scss ]; then
  echo "SCSS already exists"
  rm app/assets/stylesheets/application.css
else
  mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
fi

# ViewComponent configuration
ruby <<'RUBY'
path = "config/application.rb"
content = File.read(path)

insert = <<~CONFIG

    # ViewComponent
    config.view_component.generate.sidecar = true
    config.view_component.preview_paths << Rails.root.join("spec/components/previews")
    config.view_component.generate.stimulus_controller = true
CONFIG

content.sub!(
  /class Application < Rails::Application\n/,
  "class Application < Rails::Application\n#{insert}"
)

File.write(path, content)
RUBY

# RuboCop setup
echo "Configuring RuboCop..."

cat <<EOF > .rubocop.yml
plugins:
  - rubocop-rails
  - rubocop-performance

AllCops:
  NewCops: enable
  Exclude:
    - "bin/**/*"
    - "db/schema.rb"
    - "node_modules/**/*"

Layout/LineLength:
  Max: 100
EOF

bundle exec rubocop --auto-gen-config || true

# Font Awesome setup
echo "Configuring Font Awesome..."

cat <<EOF >> app/assets/stylesheets/application.scss

@use "font-awesome" with (
  \$fa-font-path: "font-awesome"
);
EOF

# Git init
echo "Initializing git..."

git init
git add .
git commit -m "Initial Rails 8 setup with Hotwire, ViewComponent, SASS, and tooling"

echo "Done."
echo "Next steps:"
echo "  cd $APP_NAME"
echo "  bin/dev"
