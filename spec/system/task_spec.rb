require "rails_helper"
describe "タスク管理機能", type: :system do
  before do
    @task = FactoryBot.create(:task)
  end
  describe "タスク一覧表示機能" do
    context "タスクを作成したとき" do
      before do
        visit tasks_path
      end
      it "作成したタスクが表示される" do
        expect(page).to have_content "task1"
      end
    end

    context "複数のタスクを作成したとき" do
      before do
        FactoryBot.create(:task, task_name: "task2", deadline: "2020-05-02", status: "完了", priority: "低")
        visit tasks_path
      end

      it "タスクが作成日時の降順で表示される" do
        task_list = all("#task_row")
        expect(task_list[0]).to have_content "task2"
        expect(task_list[1]).to have_content "task1"
      end

      it "終了期限の昇順で表示される" do
        visit tasks_path
        click_link "終了期限でソートする"
        task_list = all("#task_row")
        expect(task_list[0]).to have_content "task2"
        expect(task_list[1]).to have_content "task1"
      end

      it "優先順位の降順で表示される" do
        visit tasks_path
        click_link('優先順位でソートする')
        save_and_open_page
        task_list = all("#task_row")
        expect(task_list[0]).to have_content "task2"
        expect(task_list[1]).to have_content "task1"
      end

      it "タイトルでで検索できる" do
        visit tasks_path
        fill_in "task_name", with: "task1"
        click_button "検索する"
        expect(page).to have_content "task1"
      end

      it "ステータスで検索できる" do
        visit tasks_path
        select "着手中", from: "search_status"
        click_button "検索する"
        expect(page).to have_content "task1"
      end

      it "タスク名とステータスの両方で検索できる" do
        fill_in "タスク名", with: "task2"
        select "完了", from: "search_status"
        click_button "検索する"
        expect(page).to have_content "task2"
      end
    end
  end
end