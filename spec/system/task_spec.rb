require "rails_helper"
RSpec.describe 'ラベルの指定：ラベル検索機能', type: :system do
    # describe 'ユーザ登録のテスト' do
    #     context 'ユーザのデータがなくログインしていない場合' do
    #         it 'ユーザ新規登録のテスト' do
    #             visit new_user_path
    #             fill_in 'user[name]', with: 'sample'
    #             fill_in 'user[email]', with: 'sample@example.com'
    #             fill_in 'user[password]', with: '00000000'
    #             fill_in 'user[password_confirmation]', with: '00000000'
    #             click_button 'Create my account'
    #             expect(page).to have_content 'sample'
    #         end
    #     end
    # end
    describe "タスクの作成とラベルの選択", type: :system do
        before do
            FactoryBot.create(:user)
            visit sessions_new_path
            fill_in 'session[email]', with: 'sample@example.com'
            fill_in 'session[password]', with: '00000000'
            click_on 'Log in'
        end
      it "タスクの作成、
          ラベル選択,
          作成したタスクが表示される,
          ラベルで検索できる" do
        visit tasks_path
        click_on 'ラベル一覧と追加へ'
        click_on 'New Label'
        fill_in 'label[name]', with: 'ラベル１'
        click_on '登録する'
        visit tasks_path
        click_on 'タスクの作成'
        fill_in 'task[task_name]', with: 'aaaaa'
        fill_in 'task[description]', with: 'aaaaaa'
        fill_in 'task[deadline]', with: '202020-05-01-10-11'
        # find('.task_label_ids_1').click
        check 'ラベル１'
        click_on '登録する'
        expect(page).to have_content 'タスクを作成しました'
  
        visit tasks_path
        click_on '詳細'
        expect(page).to have_content "ラベル１"
 
        visit tasks_path
        select 'ラベル１', from: 'label_id'
        click_on "検索する"
        expect(page).to have_content "aaaaa"
      end
    end
end