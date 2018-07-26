require_dependency 'groups_controller'

module OpenProject::MyPlugin::Patches::GroupsControllerPatch
  def self.included(base)
    base.class_eval do

    end
  end
end

Project.send(:include, OpenProject::MyPlugin::Patches::GroupsControllerPatch)
