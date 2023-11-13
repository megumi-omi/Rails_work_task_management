require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    User.delete_all
  end
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:label) { FactoryBot.create(:label, name: 'sample_label_01') }

  describe '検索機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'test_password'
      click_on 'Log in'
    end
      context 'ラベルで検索した場合' do
      it '該当のラベルを含むタスクが表示される' do
        FactoryBot.create(:task, user: user)
        visit tasks_path
        select 'sample_label_01', from: 'search[label_id]'
        click_on '検索'
        expect(page).to have_content 'sample_label_01'
      end
    end
  end

end
# タスクの新規登録時、ラベルが登録できる →task_spec.rbに追加
# タスクの詳細画面で、タスクに紐づいているラベルを表示する→task_spec.rbに追加
# ラベルで検索できる→ラベルのテストで新規作成する