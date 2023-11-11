require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    User.delete_all
  end
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_session_path
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'test_password'
        click_on 'Log in'

        visit new_task_path
        fill_in 'task[title]', with: 'タスク1'
        fill_in 'task[content]', with: '詳細1'
        fill_in 'task[deadline]', with: DateTime
        select 'waiting', from: 'task[status]'
        click_on '登録する'
        expect(page).to have_content 'タスク1'       
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'test_password'
      click_on 'Log in'
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, title: 'task2', user: user)
        FactoryBot.create(:task, title: 'task3', user: user)
        visit tasks_path
        task_list = all('.task_row_title')
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替える' do
        FactoryBot.create(:task, deadline: '2023/11/1', user: user)
        FactoryBot.create(:task, deadline: '2023/12/1', user: user)
        FactoryBot.create(:task, deadline: '2024/1/1', user: user)
        visit tasks_path
        click_on '終了期限'
        task_list = all('.task_row_deadline')
        expect(task_list[0]).to have_content '2024-01-01'
       end
    end
    context '優先順位でソートするというリンクを押した場合' do
      it '優先順位を降順で並び替える' do
        FactoryBot.create(:task, priority: 'high', user: user)
        FactoryBot.create(:task, priority: 'medium', user: user)
        FactoryBot.create(:task, priority: 'low', user: user)
        visit tasks_path
        click_on '優先順位'
        task_list = all('.task_row_priority')
        expect(task_list[0]).to have_content 'high'
      end
    end          
  end

  describe '詳細表示機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'test_password'
      click_on 'Log in'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task', user: user)
        visit task_path(task)
        expect(page).to have_content 'task'
      end
    end
  end

  describe '検索機能' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'test_password'
      click_on 'Log in'
    end
      context 'タイトルで検索した場合' do
      it '該当のタイトルを含むタスクが表示される' do
        FactoryBot.create(:task, title: 'task2', user: user)
        FactoryBot.create(:task, title: 'task3', user: user)
        visit tasks_path
        fill_in 'task[title]', with: 'task3'
        click_on '検索'
        expect(page).to have_content 'task3'
      end
    end
    context 'ステータスで検索した場合' do
      it '該当のステータスに当てはまるタスクが表示される' do
        FactoryBot.create(:task, status: 'working', user: user)
        FactoryBot.create(:task, status: 'waiting', user: user)
        visit tasks_path
        select 'waiting', from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'waiting'
      end
    end
    context 'タイトルとステータスで検索した場合' do
      it '該当のタイトルとステータスのタスクが表示される' do
        FactoryBot.create(:task, title: 'task2', status: 'working', user: user)
        FactoryBot.create(:task, title: 'task3', status: 'waiting', user: user)
        visit tasks_path
        fill_in 'task[title]', with: 'task3'
        select 'waiting', from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'task3'
      end
    end
  end
end
