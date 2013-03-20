# lab2023 - Rails Template

This template includes

**Assets**

* sass-rails
* coffee-rails
* uglifier
* jquery-rails
* compass-rails
* bootstrap-sass
* jquery-ui-rails

**UX Companent**

* show_for
* simple_form
* haml-rails
* will_paginate
* bootstrap-will_paginate
* will-paginate-i18n
* bootstrap-datepicker-rails
* client_side_validations
* client_side_validations-simple_form

**Server site & Deployment**

* god
* resque
* resque_mailer
* whenever

**Other**

* cancan
* devise
* responders
* i18n
* paperclip
* ransack
* turbolinks
* strong_parameters

**Test**

* factory_girl_rails
* capybara
* shoulda-matchers
* rspec-rails
* guard-rspec
* rb-inotify

**Development**

* sextant
* meta_request
* better_errors

gems. Scaffold generator views which were changed under `lib/templates`
folder in templates.  When you use scaffolding, views are generated from these views. Template creates Admin namespace.
Admins don't use normal users table, they use admins table for authenticating. There is `dev.rake` in `lib/tasks` folder.
This rake do

* `db:drop`
* `db:create`
* `db:migrate`
* `db:seed`

and saving fixtures data processes. 

## Deafult Users

When template is installed, Records
which are `user@lab2023.com`  `12341234` at users table and `admin@lab2023.com` `1234134` at admins table are saved. Admin
page can be accessed from `/admins/sign_in`.

## Requirements

Before generating your application, you will need:

* The Ruby language (version 1.9.3)
* Rails 3.2

## Usage

```ruby
rails new APP_NAME -T -m https://raw.github.com/lab2023/rails-template/master/rails_template.rb
```

## Bugs and  Feedback

If you discover any bugs or want to drop a line, feel free to create an issue on GitHub.

http://github.com/lab2023/rails-template/issues

## Contributing

Once you've made your great commits:

1. Fork Template
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a Pull Request from your branch
5. That's it!

## Credits

Rails Template is maintained and funded by [lab2023 - internet technologies](http://lab2023.com/)

Thank you to all the [contributors!](https://github.com/lab2023/rails-template/graphs/contributors)

The names and logos for lab2023 are trademarks of lab2023, inc.

## License

[MIT License](http://www.opensource.org/licenses/mit-license)

Copyright 2012 lab2023 – internet technologies
