# == Schema Information
#
# Table name: goals
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  details    :text             not null
#  private    :boolean          not null
#  completed  :boolean          not null
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ApplicationRecord
  validates :title, :details, presence: true
  validates :private, :completed, inclusion: { in: [true, false] }

  belongs_to :user
end
