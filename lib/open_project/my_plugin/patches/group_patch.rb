require_dependency 'group'

module OpenProject::MyPlugin::Patches::GroupPatch
  def self.included(base)
    base.class_eval do
      
    end
  end
end

Project.send(:include, OpenProject::MyPlugin::Patches::GroupPatch)
