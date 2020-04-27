require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'task_namega空白ならバリデーションが通らない' do
    task = Task.new(name: '', description: '通らない')
    expect(task).not_to be_valid
    
  end
  it 'descriptionが空白ならバリデーションが通らない' do
    task = Task.new(name: '通らない', description: '')
    expect(task).not_to be_valid
  end


  it 'nameとdescriptionに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: 'バリデーション にクリアする', description: 'バリデーション にクリアする')
    expect(task).to be_valid
  end
end