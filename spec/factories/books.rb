# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  state      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :book do
    title { "MyString" }
    state { "MyString" }
  end
end
