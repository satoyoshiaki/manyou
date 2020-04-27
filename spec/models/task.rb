require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do


  context '新規作成画面でタスク名を入れなかったとき' do
    let(:task_name) {''}

    it 'バリデーション が働いてエラーになる' do
      whithin '#error_explanation' do
        expect(page).to have_content '名称を入力してください'
      end 
    end
  end
end