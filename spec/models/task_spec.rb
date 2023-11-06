require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト')
        expect(task).to be_valid
      end
    end
  end
  describe 'scopeのテスト' do
    context 'タイトルをあいまい検索した場合' do
      it '該当のタイトルを含むタスクが表示される' do
        task = Task.create(title: 'title1', content: 'content1', deadline: '2023/12/1', status: 'completed')
        task = Task.create(title: 'title2', content: 'content2', deadline: '2023/12/10', status: 'working')
        task = Task.create(title: 'title3', content: 'content3', deadline: '2023/12/20', status: 'waiting')
        expect(Task.search_title('3')).to include("title3")
      end
    end
    context 'ステータスで検索した場合' do
      it '該当のステータスを含むタスクが表示される' do
      end
    end
    context 'タイトルをあいまい検索、ステータスを検索した場合' do
      it '該当のタイトル・ステータスを含むタスクが表示される' do
      end
    end
  end
end