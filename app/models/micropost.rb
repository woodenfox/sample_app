# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  default_scope order: 'microposts.created_at DESC'

  validates :content, presence: true, length: { maximum: 240}
  validates :user_id, presence: true

end
