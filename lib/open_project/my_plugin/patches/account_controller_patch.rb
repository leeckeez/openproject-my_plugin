require_dependency 'account_controller'

module OpenProject::MyPlugin::Patches::AccountControllerPatch
  def self.included(base)
    base.class_eval do
      
    end
  end
end

Project.send(:include, OpenProject::MyPlugin::Patches::AccountControllerPatch)
