# OpenProject My_Plugin 

In this plugin I try to develop a openproject plugin that can easily create many accounts with uploading the file(typically the .csv file).

## Pre-requiresites

In order to be able to continue, you will first have to have the following items installed:
* Ruby 2.x
* Ruby on Rails 5.x
* Node 6.x, NPM 4.x and bundles
* OpenProject core branch stable/7


## Getting started

To include this plugin, you need to create a file called 'Gemfile.plugins' in your OpenProject directory with the following contents:

```
group :opf_plugins do
	gem "openproject-my_plugin", git: "git@github.com:opf/openproject-my_plugin.git", branch: "master"
end
```

If you already have a 'Gemfile.plugins', just add the line "gem" line to it inside the ':opf_plugins' group.

Once you've done that run:

```
$ bundle install
$ bundle exec rails db:migrate  # creates the models from the plugin
$ bundle exec rails db:seed  # creates default data from the plugin's seeder ('app/seeders')
$ bundle exec rails assets:webpack
```

Start the server using:

```
$ bundle exec rails s
```
In order to verify that the plugin has been installed correctly, go to the Administration Plugins Page at '/adim/plugins' and you should be able to find the plugin in the list.

![plugin list]()

In the following section I will explain the features and list the relevant files. Beyond that there are also code comments in the respective files which provide further details.

### Rails generators

The plugin comes with an executable 'bin/rails' which you can use when calling rails generator for generating everything. You will have to define 'OPENPROJECT_ROOT' in your environment for it to work, because the plugin requires the core to load.

By 'core' I mean the directory under which you originally checkedout the OpenProject repository:

```
$ git clone https://github.com/opf/openproject.git ~/dev/openproject/core
$ git checkout dev
```

So you can set it like this, for instance in your '.bashrc':

```
export OPENPROJECT_ROOT=~/dev/openproject/core 
```

Once you've set that up you can use the rails generators as usual.

For instance this is how you could **generate a model**:

```
$ bundle exec rails generate model User name:string email:string
	invoke 	active_record
	create		db/migrate/201806230923_create_users.rb
	create 		app/models/user.rb
	invoke		test_unit
	create 		test/models/user_test.rb
	create 		test/fixtures/users.yml
```

Finally, don't forget to run the migration form the core directory:

```
$ cd $OPENPROJECT_ROOT
$ bundle exec rails db:migrate
```

## Models

The relevant files for the models are:

* `app/models/accountcreator.rb` - the code for the model where you can add validations etc.
* `app/models/application_record.rb` - auto-generated base record
* `db/migrate/20180725131010_create_accountcreators.rb` - database migration

The model has a method called `import` which in charge of importing the .csv file.

```ruby
class Accountcreator < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      attributes = {login: row['user id'].to_s,
                    firstname: row['first name'].to_s,
                    lastname: row['last name'].to_s,
                    mail: row['email'].to_s}

      group_name = {groupname: row['group name'].to_s}

      begin
        @user = User.find_by_login(row['user id']) || @user = User.new(attributes)
        @group = Group.find_by(group_name) || @group = Group.new(group_name)
        @group.users << @user
        @user.save!
        @group.save!
      rescue => e
        "#{attributes} #{e.message}"
      end
    end
  end
end

```

## Controllers

The relevant files for the controllers are:

* `app/controllers/accountcreators_controller` - main controller with `:index` entry point
* `app/views/accountcreators/index.html.erb` - main template for accountcreators index view

The controllers works as showing the page of plugin and importing the file:

```ruby
class AccountcreatorsController < ApplicationController
	layout 'admin'
	before_action :require_admin  #require admin to access the page

	def index
		@users = User.all
	end

	def import 
		Accountcreator.import(params[:file])
		redirect_to users_path, notice: "Users Added Successfully and Groups Created Successfully"
	end

end
```

## Assets

The relevant files for the assets are:

* `app/assets/javascripts/my_plugin/main.js` - main entry point for plain JavaScript and document ready hook.
* `app/assets/stylesheets/my_plugin/main.scss` - main Sass file.

I put the assets into a subfolder with the same name as my plugin in order to avoid naming conflicts with the core.

## Homescreen Blocks

By default the homepage contains a number of blocks (widget boxes), such as: "Projects", "Users", "My account", "Openproject community", "Administration".

In order to show the plugin, I add the own-defined block so that it can appear on the homepage.

The relevant files for homescreen blocks are:

* `lib/open_project/my_plugin/engine.rb` - 'my_plugin.homescreen_blocks' initializer
* `lib/views/homescreen/blocks/_homescreen_block.html.erb`

Register additional blocks in OpenProject's homescreen in the file 'engine.rb'

```
initializer 'my_plugin.homescreen_blocks' do
      OpenProject::Static::Homescreen.manage :blocks do |blocks|
        blocks.push(
          { partial: 'homescreen_block', if: Proc.new { true } }
        )
      end
end
```

The partial file '_homescreen_block.html.erb' provides the page for which the contents of the block will be generated.








