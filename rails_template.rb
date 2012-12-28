#####################################################
# Application Generator Template
# Usage: rails new APP_NAME  -T -m https://raw.github.com/lab2023/rails-template/master/rails_template.rb
#
# If you are customizing this template, you can use any methods provided by Thor::Actions
# http://rubydoc.info/github/wycats/thor/master/Thor/Actions
# and Rails::Generators::Actions
# http://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
#####################################################


@path = 'https://raw.github.com/lab2023/rails-template/master/files/'

if yes?('Would you like to use the Sphinx search system? (yes/no)')
  sphinx_flag = true
else
  sphinx_flag = false
end

if sphinx_flag
  puts "Adding thinking-sphinx gem ..."
  gem 'thinking-sphinx'
end

if yes?('Would you like to use resque for background job? (yes/no)')
  resque_flag = true
else
  resque_flag = false
end

if resque_flag
  puts "Adding resque gem ..."
  gem 'resque'
  puts "Creating lib/tasks/resque.rake ..."
  create_file 'lib/tasks/resque.rake' do <<-'FILE'
  require "resque/tasks"
  task "resque:setup" => :environment
  FILE
  end
end

if yes?('Would you like to use resque_mailer for sending email with background job? (yes/no)')
  resque_mailer = true
else
  resque_mailer = false
end

if resque_mailer
  puts "Adding resque_mailer gem  ..."
  gem 'resque_mailer'
  puts "Adding god gem for resque production ..."
  gem 'god', :require => false
  puts "Creating config/initializers/resque_mailer.rb ..."
  create_file 'config/initializers/resque_mailer.rb' do <<-'FILE'
  class AsyncMailer < ActionMailer::Base
    include Resque::Mailer
    layout 'email'
  end
  FILE
  end
end

# Gems

gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem "will-paginate-i18n", "~> 0.1.7"
gem 'cancan'
gem 'devise'
gem 'haml-rails'
gem 'responders'
gem 'show_for'
gem 'simple_form'
gem 'i18n'
gem 'bootstrap-datepicker-rails'
gem 'paperclip'
gem 'whenever', :require => false


gem_group :assets do
  gem 'bootstrap-sass'
  gem 'compass-rails'
  gem 'jquery-ui-rails'
end

gem_group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails", "~> 2.6"
  gem "guard-rspec"
  gem 'rb-fchange', :require => false if RUBY_PLATFORM =~ /mswin/i
  gem 'rb-inotify', :require => false if RUBY_PLATFORM =~ /linux/i
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl', '1.0.3', :require => false if RUBY_PLATFORM =~ /darwin/i
end

group :test do
  gem "factory_girl_rails", "~> 4.0"
  gem "capybara"
  gem 'shoulda-matchers'
end

gem_group :production do
  gem 'mysql2'
end


# Bundle

run 'bundle install'
rake 'db:drop'
rake 'db:create'
rake 'db:migrate'
run 'wheneverize .'
run 'rails g rspec:install'
run 'mkdir spec/support spec/models spec/routing'
run 'guard init spec'


# Lib

# Spec
get @path + 'lib/spec/spec_helper.rb', 'spec/spec_helper.rb'

# application.rb
inject_into_file 'config/application.rb', :after => "config.assets.version = '1.0'" do <<-RUBY


    config.generators do |g|
      g.fixture_replacement :factory_girl
    end


RUBY
end


# Haml views
get @path + 'lib/templates/haml/scaffold/edit.html.haml', 'lib/templates/haml/scaffold/edit.html.haml'
get @path + 'lib/templates/haml/scaffold/index.html.haml', 'lib/templates/haml/scaffold/index.html.haml'
get @path + 'lib/templates/haml/scaffold/new.html.haml', 'lib/templates/haml/scaffold/new.html.haml'
get @path + 'lib/templates/haml/scaffold/show.html.haml', 'lib/templates/haml/scaffold/show.html.haml'

# controller
get @path + 'lib/templates/rails/responders_controller/controller.rb', 'lib/templates/rails/responders_controller/controller.rb'

# rake
get @path + 'lib/tasks/dev.rake', 'lib/tasks/dev.rake'

# SettingsLogic
get @path + 'settings_logic/config.yml', 'config/application.yml'

# Application Layout
remove_file 'app/views/layouts/application.html.erb'
get @path + 'app/views/layouts/application.html.haml', 'app/views/layouts/application.html.haml'
get @path + 'app/views/layouts/admins/application.html.haml', 'app/views/layouts/admins/application.html.haml'

remove_file 'app/assets/javascripts/application.js'
get @path + 'app/assets/javascripts/application.js', 'app/assets/javascripts/application.js'
get @path + 'app/assets/javascripts/jquery.validate.js', 'app/assets/javascripts/jquery.validate.js'
get @path + 'app/assets/javascripts/jquery.validate.bootstrap.js', 'app/assets/javascripts/jquery.validate.bootstrap.js'
get @path + 'app/assets/stylesheets/application.css.scss', 'app/assets/stylesheets/application.css.scss'

# SimpleForm
generate 'simple_form:install --bootstrap'

# Devise
generate 'devise:install'
gsub_file 'config/application.rb', /:password/, ':password, :password_confirmation'
generate 'devise user name:string'
gsub_file 'app/models/user.rb', /:remember_me/, ':remember_me, :role_id, :avatar, :name'

gsub_file 'config/routes.rb', /  devise_for :users/ do <<-RUBY
  devise_for :users
RUBY
end

gsub_file 'config/initializers/devise.rb', /please-change-me-at-config-initializers-devise@example.com/, 'CHANGEME@example.com'

inside 'app/views/devise' do
  get @path + 'app/views/devise/confirmations/new.html.haml', 'confirmations/new.html.haml'
  get @path + 'app/views/devise/mailer/confirmation_instructions.html.haml', 'mailer/confirmation_instructions.html.haml'
  get @path + 'app/views/devise/mailer/reset_password_instructions.html.haml', 'mailer/reset_password_instructions.html.haml'
  get @path + 'app/views/devise/mailer/unlock_instructions.html.haml', 'mailer/unlock_instructions.html.haml'
  get @path + 'app/views/devise/passwords/edit.html.haml', 'passwords/edit.html.haml'
  get @path + 'app/views/devise/passwords/new.html.haml', 'passwords/new.html.haml'
  get @path + 'app/views/devise/registrations/edit.html.haml', 'registrations/edit.html.haml'
  get @path + 'app/views/devise/registrations/new.html.haml', 'registrations/new.html.haml'
  get @path + 'app/views/devise/sessions/new.html.haml', 'sessions/new.html.haml'
  get @path + 'app/views/devise/shared/_links.haml', 'shared/_links.html.haml'
  get @path + 'app/views/devise/unlocks/new.html.haml', 'unlocks/new.html.haml'
end

# Admins
generate 'devise admin name:string'
gsub_file 'config/routes.rb', /  devise_for :admins/ do <<-RUBY
   devise_for :admins, :controllers => { :sessions => "admins/sessions", :registrations =>  "admins/registrations"}
   namespace :admins do
    resources :dashboard
  end
RUBY
end
get @path + 'app/controllers/admins/application_controller.rb', 'app/controllers/admins/application_controller.rb'
get @path + 'app/controllers/admins/dashboard_controller.rb', 'app/controllers/admins/dashboard_controller.rb'
get @path + 'app/controllers/admins/sessions_controller.rb', 'app/controllers/admins/sessions_controller.rb'
get @path + 'app/controllers/admins/registrations_controller.rb', 'app/controllers/admins/registrations_controller.rb'
get @path + 'app/views/admins/dashboard/index.html.haml', 'app/views/admins/dashboard/index.html.haml'
get @path + 'app/views/admins/sessions/new.html.haml', 'app/views/admins/sessions/new.html.haml'
get @path + 'app/views/admins/registrations/edit.html.haml', 'app/views/admins/registrations/edit.html.haml'



# admin.rb, user.rb and profile avatar image
remove_file 'app/models/user.rb'
remove_file 'app/models/admin.rb'
get @path + 'app/models/user.rb', 'app/models/user.rb'
get @path + 'app/models/admin.rb', 'app/models/admin.rb'
get 'https://github.com/lab2023/rails-template/raw/master/files/app/assets/images/default-avatar.gif', 'app/assets/images/default-avatar.gif'

rake 'db:migrate'

# Role Table
generate 'model role name:string'

# Responder
generate 'responders:install'

# Responder
generate 'show_for:install'

# CanCan
generate 'cancan:ability'

# Welcome and Dashboard
generate(:controller, 'pages')

inject_into_file 'app/controllers/pages_controller.rb', :before => 'end' do <<-RUBY
  skip_before_filter :authenticate_user!, :only => :index

  def index

  end


RUBY
end

route "root :to => 'pages#index'"
get @path + 'app/views/pages/index.html.haml', 'app/views/pages/index.html.haml'



# Locale Settings

inject_into_file 'config/application.rb', :after => 'class Application < Rails::Application' do <<-RUBY


    config.time_zone = 'Istanbul'
    config.i18n.default_locale = :tr


RUBY
end


remove_file "config/locales/devise.en.yml"
remove_file "config/locales/en.yml"
remove_file "config/locales/responder.en.yml"
remove_file "config/locales/responders.en.yml"
remove_file "config/locales/show_for.en.yml"

get @path + 'config/locales/i18n/pluralization.rb', 'config/locales/i18n/pluralization.rb'
get @path + 'config/locales/active_model.en.yml', 'config/locales/active_model.en.yml'
get @path + 'config/locales/active_model.tr.yml', 'config/locales/active_model.tr.yml'
get @path + 'config/locales/active_record.en.yml', 'config/locales/active_record.en.yml'
get @path + 'config/locales/active_record.tr.yml', 'config/locales/active_record.tr.yml'
get @path + 'config/locales/default.en.yml', 'config/locales/default.en.yml'
get @path + 'config/locales/default.tr.yml', 'config/locales/default.tr.yml'
get @path + 'config/locales/devise.tr.yml', 'config/locales/devise.tr.yml'
get @path + 'config/locales/devise.en.yml', 'config/locales/devise.en.yml'
get @path + 'config/locales/en.yml', 'config/locales/en.yml'
get @path + 'config/locales/tr.yml', 'config/locales/tr.yml'
get @path + 'config/locales/helpers.en.yml', 'config/locales/helpers.en.yml'
get @path + 'config/locales/helpers.tr.yml', 'config/locales/helpers.tr.yml'
get @path + 'config/locales/mails.tr.yml', 'config/locales/mails.tr.yml'
get @path + 'config/locales/mails.en.yml', 'config/locales/mails.en.yml'
get @path + 'config/locales/models.en.yml', 'config/locales/models.en.yml'
get @path + 'config/locales/models.tr.yml', 'config/locales/models.tr.yml'
get @path + 'config/locales/nav.tr.yml', 'config/locales/nav.tr.yml'
get @path + 'config/locales/nav.en.yml', 'config/locales/nav.en.yml'
get @path + 'config/locales/pages.en.yml', 'config/locales/pages.en.yml'
get @path + 'config/locales/pages.tr.yml', 'config/locales/pages.tr.yml'
get @path + 'config/locales/responders.tr.yml', 'config/locales/responders.tr.yml'
get @path + 'config/locales/responders.en.yml', 'config/locales/responders.en.yml'
get @path + 'config/locales/show_for.en.yml', 'config/locales/show_for.en.yml'
get @path + 'config/locales/show_for.tr.yml', 'config/locales/show_for.tr.yml'
get @path + 'config/locales/simple_form.tr.yml', 'config/locales/simple_for.tr.yml'
get @path + 'config/locales/simple_form.en.yml', 'config/locales/simple_for.en.yml'
get @path + 'config/locales/title.en.yml', 'config/locales/title.en.yml'
get @path + 'config/locales/title.tr.yml', 'config/locales/title.tr.yml'
get @path + 'config/locales/validates_timeliness.tr.yml', 'config/locales/validates_timeliness.tr.yml'




# Mail Settings

inject_into_file 'config/environments/development.rb', :after => 'config.assets.debug = true' do <<-RUBY

  #Mail Settings
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'gmail.com',
      :user_name            => 'rubyonrailsrailsmailtest@gmail.com',
      :password             => 'secret',
      :authentication       => 'plain',
      :enable_starttls_auto => true
  }
RUBY
end

inject_into_file 'config/environments/production.rb', :after => 'config.active_support.deprecation = :notify' do <<-RUBY

  #Mail Settings
  config.action_mailer.default_url_options = { :host => 'www.example.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'gmail.com',
      :user_name            => 'user@gmail.com',
      :password             => 'secret',
      :authentication       => 'plain',
      :enable_starttls_auto => true
  }

RUBY
end

#Email layout

get @path + 'app/views/layouts/email.html.haml', 'lib/templates/app/views/layouts/email.html.haml'
# Controller

remove_file 'app/controllers/application_controller.rb'
get @path + 'app/controllers/application_controller.rb', 'app/controllers/application_controller.rb'



#Title Helper

inject_into_file 'app/helpers/application_helper.rb', :before => 'end' do <<-RUBY
  def title(page_title)
    content_for(:title) { page_title }
  end
RUBY
end



# Clean-up

%w{
  README
  doc/README_FOR_APP
  public/index.html
  app/assets/images/rails.png
}.each { |file| remove_file file }

#Change Application Name
gsub_file 'app/views/layouts/application.html.haml', /Change Me/, "#{app_name.humanize.titleize}"
gsub_file 'app/views/layouts/admins/application.html.haml', /Change Me/, "#{app_name.humanize.titleize}"

# Git

append_file '.gitignore' do <<-GIT
/public/system
/public/uploads
/coverage
rerun.txt
.rspec
capybara-*.html
.DS_Store
.rbenv-vars
.rbenv-version
.bundle
db/*.sqlite3
db/database.yml
log/*.log
log/*.pid
.sass-cache/
tmp/**/*
.rvmrc
.DS_Store
db-dumps
**/.DS_Store
nbproject/**/*
.yardoc/**/*
.yardoc
nbproject
.idea
.idea/**/*
GIT
end


remove_file 'app/assets/stylesheets/application.css'
rake 'db:migrate'
generate 'paperclip user avatar'
rake 'dev:setup'


git :init
git :add => '.'
git :commit => '-m "Issue #1 Install Rails "'