# Rails Template

This template includes 

* `devise` 
* `simple_form` 
* `responder` 
* `show_for` 
* `paperclip` 
* `will_paginate`
* `haml`
* `bootstrap-datepicker-rails` 
* `bootstrap` 

gems. Scaffold generator views which were changed under `lib/templates`
folder in templates.  When you use scaffolding, views are generated from these views. Template creates Admin namespace.
Admins don't use normal users table, they use admins table for authenticating. There is `dev.rake` in `lib/tasks` folder.
This rake do 

* `db:drop` 
* `db:create` 
* `db:migrate` 
* `db:seed` 

and saving fixtures data processes. When template is installed, Records 
which are `user@lab2023.com`  `12341234` at users table and `admin@lab2023.com` `1234134` at admins table are saved. Admin
page can be accessed from `/admins/sign_in`.

#Usage

```ruby
rails new APP_NAME -T -m https://raw.github.com/lab2023/template/master/rails_template.rb
```
