module OpenProject::MyPlugin

	class Hooks < Redmine::Hook::ViewListener

	render_on :view_layouts_base_html_head, inline: <<-VIEW
		<% content_for :header_tags do %>
  			<%= stylesheet_link_tag 'my_plugin/main', plugin: :openproject_my_plugin %>
  			
		<% end %>
		VIEW
	
	end
end
