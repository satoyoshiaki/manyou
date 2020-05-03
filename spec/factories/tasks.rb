FactoryBot.define do
  factory :task do
    task_name { 'task1' }
    description { 'text1' }
    deadline { '2020-05-01' }
    status { '着手中' }
    priority { '高' }
  end
end