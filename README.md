lab2023 - Rails Template
=========

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

Requirements
------------
Before generating your application, you will need:

* The Ruby language (version 1.9.3)
* Rails 3.2

Usage
-----
```ruby
rails new APP_NAME -T -m https://raw.github.com/lab2023/template/master/rails_template.rb
```

Bugs and  Feedback
------------
If you discover any bugs or want to drop a line, feel free to create an issue on GitHub.

http://github.com/lab2023/template/issues

Contributing
------------

Once you've made your great commits:

1. Fork Tempalte
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a Pull Request from your branch
5. That's it!

Credits
-------

![lab2023 - internet tecnologics](http://lab2023.com/wp-content/uploads/2011/07/logo.png)

Template is maintained  by [lab2023 - internet technologics](http://lab2023.com/)

License
-------

[MIT License](http://www.opensource.org/licenses/mit-license)

Copyright 2012 lab2023 – internet technologies