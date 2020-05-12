require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'sample'
        fill_in 'user[email]', with: 'sample@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_button 'Create my account'
        expect(page).to have_content 'sample'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  
  describe 'セッション機能のテスト' do
    context 'ユーザーを登録している場合' do
        before do
            FactoryBot.create(:user)
            FactoryBot.create(:admin_user)
            visit sessions_new_path
            fill_in 'session[email]', with: 'sample@example.com'
            fill_in 'session[password]', with: '00000000'
            click_on 'Log in'
        end
      it 'ログインができること、ログインしたユーザーのマイページに遷移できる' do
            visit user_path(id: 1)
            expect(page).to have_content 'sample'
      end
      it '一般ユーザーが他ユーザの詳細画面に飛ぶとタスク一覧ページに遷移する' do
        visit sessions_new_path
        fill_in 'session[email]', with: 'sample@example.com'
        fill_in 'session[password]', with: '00000000'
        click_on 'Log in'
        visit user_path(id: 2)
        expect(page).to have_content 'Logout'
      end

      it '一般ユーザーは管理画面にアクセスできない' do

        visit admin_users_path
        expect(page).to have_content 'あなたは管理者ではありません'
      end

      it 'ログアウトができること' do
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
  end
end


  describe '管理画面のテスト' do
      context '管理者は管理画面にアクセスできること' do
        before do
            FactoryBot.create(:admin_user)
            visit sessions_new_path
            fill_in 'session[email]', with: 'admin@example.com'
            fill_in 'session[password]', with: '00000000'
            click_on 'Log in'
            visit admin_users_path
            expect(current_path).to eq admin_users_path
        end

        it '管理画面にアクセス' do
            visit admin_users_path
            expect(current_path).to eq admin_users_path
        end
    



      it '管理者はユーザーを作成できる' do
        visit admin_users_path
        click_on '新規登録'
        fill_in 'user[name]', with: 'asdfg'
        fill_in 'user[email]', with: 'qeqwerg@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        check 'user_admin'
        click_on '作成する'
        expect(page).to have_content 'asdfg'
      end


      it '管理者はユーザーの詳細画面にアクセスできること' do
        visit user_path(id: 2)
      end
      it '管理者はユーザーの編集画面からユーザーを編集できること' do
        click_on '編集', match: :first
        expect(page).to have_content '編集'
      end
      it '管理者はユーザーを削除できる、管理者は必ず一人以上必要なこと' do
        visit admin_users_path
        click_on '削除', match: :first
        expect(page).to have_content '必ず管理者は１人以上必要です。'
      end

    end
  end

end