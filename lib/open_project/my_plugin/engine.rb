# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject::MyPlugin
  class Engine < ::Rails::Engine
    engine_name :openproject_my_plugin

    include OpenProject::Plugins::ActsAsOpEngine

    register 'openproject-my_plugin',
             :author_url => 'https://openproject.org',
             :requires_openproject => '>= 6.0.0'


  patches [:User, :Group, :GroupsController, :AccountController]

	initializer 'my_plugin.register_hooks' do
		require 'open_project/my_plugin/hooks'
	end


	initializer 'my_plugin.homescreen_blocks' do
      OpenProject::Static::Homescreen.manage :blocks do |blocks|
        blocks.push(
          { partial: 'homescreen_block', if: Proc.new { true } }
        )
      end
    end

	assets %w(my_plugin/main.css)
  end
end
