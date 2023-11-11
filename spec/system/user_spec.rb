require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe '新規登録機能'do
    context 'ユーザを新規登録した場合' do
      it 'マイページが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'test_name'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on '登録する'
        expect(page).to have_content 'test_name'
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page.current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:user, name: 'test_name2', email: 'test02@example.com' )
      visit new_session_path
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'test_password'
      click_on 'Log in'
    end
      context '正しいログイン情報を入力した場合' do
        it 'ログインできる' do
          expect(page).to have_content 'test_name'
        end
        it 'マイページにアクセスできる' do
          expect(page.current_path).to eq user_path(@user)
        end
        it 'ログアウトできる' do
          click_on 'ログアウト'
          expect(page).to have_content 'ログアウトしました'
        end
      end
      context '一般ユーザが他人の詳細画面に飛ぶ場合' do
        it '自分のタスク一覧画面に遷移する' do
          visit user_path(@second_user)
          expect(page.current_path).to eq tasks_path
        end
      end
  end
  describe '管理画面のテスト' do
    before do
      @user = FactoryBot.create(:user, name: 'test_name2', email: 'test02@example.com' )
      @admin_user = FactoryBot.create(:user, admin: 'true')
      visit new_session_path
    end
    context '管理ユーザでログインした場合' do
      it '管理画面にアクセスできる' do
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'
        expect(page.current_path).to eq admin_users_path
      end
      it 'ユーザの新規登録ができる' do
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'

        click_on '新規登録'
        fill_in 'Name', with: 'test_name03'
        fill_in 'Email', with: 'test03@example.com'
        fill_in 'Password', with: 'test_password'
        fill_in 'Password confirmation', with: 'test_password'
        click_on '登録する'
        expect(page).to have_content '一般ユーザを作成しました'
      end
      it 'ユーザの詳細画面にアクセスできる' do
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'
        click_on "詳細", match: :first
        expect(page.current_path).to eq user_path(@user)
      end
      it 'ユーザが削除できる' do
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'
        click_on '削除', match: :first
        expect(User.count).to eq 1
      end
      it 'ユーザ情報が編集できる ' do
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'
        click_on '編集', match: :first
        fill_in 'user[name]', with: 'sample'
        click_on '更新'
        expect(page).to have_content 'ユーザ情報を更新しました'
      end
    end
    context '一般ユーザでログインした場合' do
      it '管理画面にアクセスできない' do
        fill_in 'Email', with: 'test02@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'
        expect(page.current_path).not_to eq admin_users_path
      end
    end
  end
end
