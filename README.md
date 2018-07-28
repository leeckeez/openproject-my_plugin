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


## Issue Tracker

https://community.openproject.org/projects/my-plugin/work_packages
