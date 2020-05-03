require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'task_nameが空ならバリデーションが通らない' do
    task = Task.new(task_name: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'descriptionが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'task_nameとdescriptionに内容が記載されていればバリデーションが通る' do
    task = Task.new(task_name: '成功テスト', description: '成功テスト')
    expect(task).to be_valid
  end

  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(task_name: "task1", description: "naiyou1", deadline: '2020-05-01 01:00:00', priority: "低", status: "未着手")
      Task.create(task_name: "task2", description: "naiyou2", deadline: '2020-05-01 02:00:00', priority: "中", status: "着手中")
      Task.create(task_name: "task3", description: "naiyou3", deadline: '2020-05-01 03:00:00', priority: "高", status: "完了")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.title_search('task1').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.status_search('未着手').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.title_search('task3').status_search('完了').count).to eq 1
    end
  end
end

