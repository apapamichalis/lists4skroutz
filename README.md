Lists4skroutz: skroutz_1 team project
================

This app uses the skroutz [ruby api client](https://github.com/skroutz/skroutz.rb) to create lists of SKUs. Several features will be added in time.

To speed up development, this application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.


Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.4.0
- Rails 5.0.3

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started with this app
---------------
First of all you will need a development environment with Ruby 2.4.0, Rails 5.0.3 and mysql server installed. (The procedure is explained in detail for your OS in [GoRails website](https://gorails.com/setup/)). <em>For users of our vagrant VM, refer to Ubuntu 16.04 section with the use of rbenv</em>. 
##### Notes: 
* No need to install PostgreSQL at this time.
* The above tutorial installs rails version 5.0.1. Either change this to 5.0.3 in the corresponding step, or ```bundle install``` command on step 3 below will take care of this for you.

To get the app running on your system you will need to follow the steps:

1) Clone the app: ```git clone https://github.com/apapamichalis/lists4skroutz```
2) Enter the app directory: ```cd lists4skroutz/```
3) Install the gems: ```bundle install```
4) Setup [figaro gem](https://github.com/laserlemon/figaro): ```bundle exec figaro install```
5) Add <b>your</b> credentials at the end of your config/application.yml in the following format:

```ruby
mysql_username: 'YOUR_USERNAME_FOR_MYSQL' # should be 'root' for most users
mysql_password: 'YOUR_PASSWORD_FOR_MYSQL'
skroutz_id:     'YOUR_SKROUTZ_ID'
skroutz_secret: 'YOUR_SKROUTZ_SECRET'
```

6) Create the tables in the db: ```rake db:create:all```
7) Do the db migration: ```rake db:migrate```
8) Seed the db: ```rake db:seed```
9) And finally, start the rails server: ```rails s```

You can now visit [http://localhost:3000](http://localhost:3000) <em>(or [http://localhost:3100](http://localhost:3100) for those of us that are using our vagrant VM, where 3000 port is being redirected)</em> to see our fabulous app in all its glory! 


Issues
-------------
Feel free to report and/or resolve issues! This project's coordinator is <b>gbassis</b>.

Contributing
------------
Contributing involves:
1) Reporting issues
2) Fixing bugs
3) Implemented features
Feel free to contribute any way you like! You only need to: 
1) Clone the project locally with ```git clone https://github.com/apapamichalis/lists4skroutz```
2) Create a local branch with ```git checkout -b descriptive-branch-name```
3) Make your changes locally and save them.
4) Add any new files you have created locally in the local repo with ```git add .```
5) Commit the changes locally with ```git commit -m "Your description goes in here"``` <b>Always use present, imperative tense and be descriptive in your messages!</b><em> For example: "Add lists controller" or "Fix form partial to include email". <b>Never</b> use past tense like: "Added lists controller" etc.
6) Pull the master ```git pull orogin master```
7) Push your branch to master! ```git push origin descriptive-branch-name```

<em>For the last step to work, you need to be part of the project's collaborators...! Please notify me through slack to send you an invitation</em>

Credits
-------

License
-------
