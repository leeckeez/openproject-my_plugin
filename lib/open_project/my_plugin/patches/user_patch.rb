require_dependency 'user'

module OpenProject::MyPlugin::Patches::UserPatch
  def self.included(base)
    base.class_eval do
      has_one :mp_user
    end
  end
end

Project.send(:include, OpenProject::MyPlugin::Patches::UserPatch)
