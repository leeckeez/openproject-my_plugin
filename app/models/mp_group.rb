class MpGroup < ActiveRecord::Base
  belongs_to :group

  validates_presence_of :group
end
