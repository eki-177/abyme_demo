require "rails_helper"

RSpec.describe "Nested attributes behaviour", type: :system do
  context "Creating a brand new project" do
    it 'creates a project without any tasks' do
      visit new_project_path
      fill_in('project_title', with: "A project with no task")
      fill_in('project_description', with: "La mise en abyme — également orthographiée mise en abysme ou plus rarement mise en abîme1 — est un procédé consistant à représenter une œuvre dans une œuvre similaire, par exemple dans les phénomènes de « film dans un film », ou encore en incrustant dans une image cette image elle-même (en réduction).")    
      click_on('Save')
      expect(Project.last.title).to eq("A project with no task")
    end

    it "creates a project along with a few tasks", js: true do
      visit new_project_path
      fill_in('project_title', with: "A project with two tasks")
      fill_in('project_description', with: "La mise en abyme — également orthographiée mise en abysme ou plus rarement mise en abîme1 — est un procédé consistant à représenter une œuvre dans une œuvre similaire, par exemple dans les phénomènes de « film dans un film », ou encore en incrustant dans une image cette image elle-même (en réduction).")    
      2.times { find("div", id: "add-task").click }
      titles = find_all_by_id('input', /project_tasks_attributes_\d*_title/)
      descriptions = find_all_by_id('textarea', /project_tasks_attributes_\d*_description/ )
      titles.each_with_index {|title, n| title.fill_in(with: "Task #{n + 1}") }
      descriptions.each_with_index {|title, n| title.fill_in(with: "Small description for task number #{n + 1}") }
      click_on('Save')
      expect(Project.last.title).to eq('A project with two tasks')
      expect(Project.last.tasks.count).to eq(2)
    end

    it "creates a project along with a few tasks, each with a few comments", js: true do
      visit new_project_path
      fill_in('project_title', with: "Another project with two tasks")
      fill_in('project_description', with: "La mise en abyme — également orthographiée mise en abysme ou plus rarement mise en abîme1 — est un procédé consistant à représenter une œuvre dans une œuvre similaire, par exemple dans les phénomènes de « film dans un film », ou encore en incrustant dans une image cette image elle-même (en réduction).")    
      2.times { find("div", id: "add-task").click }
      titles = find_all_by_id('input', /project_tasks_attributes_\d*_title/)
      descriptions = find_all_by_id('textarea', /project_tasks_attributes_\d*_description/ )
      titles.each_with_index {|title, n| title.fill_in(with: "Task #{n + 1}") }
      descriptions.each_with_index {|title, n| title.fill_in(with: "Small description for task number #{n + 1}") }
      add_comment_buttons = all('div', id: "add-comment")
      add_comment_buttons.each {|b| 2.times { b.click } }
      comment_contents = find_all_by_id('input', /content/)
      comment_contents.each_with_index {|c, n| c.fill_in(with: "Comment ##{n}") }
      click_on('Save')
      expect(Project.last.comments.count).to eq(4)
    end
  end

  context "Updating an existing project" do
    before(:all) { @project = create(:project) }

    it 'updates a project without any tasks' do
      visit edit_project_path(@project)
      fill_in('project_title', with: "A rather small project")
      click_on('Save')
      @project.reload
      expect(@project.title).to eq('A rather small project')
    end

    it 'updates a project by adding a few tasks', js: true do
      visit edit_project_path(@project)
      fill_in('project_title', with: "A rather small project")
      click_on('Save')
      @project.reload
      expect(@project.title).to eq('A rather small project')
    end

  end
end

def find_all_by_id(element, matcher)
  all(element) {|el| el[:id].match? matcher }
end