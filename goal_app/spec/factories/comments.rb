# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  commentable_type :string
#  commentable_id   :bigint(8)
#  body             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :comment do
    commentable { nil }
    body { "MyText" }
  end
end
