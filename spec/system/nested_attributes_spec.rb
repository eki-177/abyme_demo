require "rails_helper"

RSpec.describe "Nested attributes behaviour" , type: :system do
  context "Creating a brand new project", js: true do
    it 'creates a project without any tasks' do
      visit new_project_path
      fill_in('project_title', with: "A nice project")
      fill_in('project_description', with: "La mise en abyme — également orthographiée mise en abysme ou plus rarement mise en abîme1 — est un procédé consistant à représenter une œuvre dans une œuvre similaire, par exemple dans les phénomènes de « film dans un film », ou encore en incrustant dans une image cette image elle-même (en réduction).")
      click_on('Save')
      expect(Project.last.title).to eq("A nice project")
    end

    it "creates a project along with a few tasks" do
      visit new_project_path
      fill_in('project_title', with: "A project with two tasks")
      fill_in('project_description', with: "La mise en abyme — également orthographiée mise en abysme ou plus rarement mise en abîme1 — est un procédé consistant à représenter une œuvre dans une œuvre similaire, par exemple dans les phénomènes de « film dans un film », ou encore en incrustant dans une image cette image elle-même (en réduction).")
      click_on('Add Task')
      within("div.project_tasks_title[data-children-count="1"]") do
        fill_in('')

      end
      click_on('Save')
      expect(Project.last.title).to eq("A nice project")
    end
  end

  context "Updating an existing project", js: true do
    it 'updates a project without any tasks' do
      project = create(:project)
      visit edit_project_path(project)
      fill_in('project_title', with: "A rather small project")
      click_on('Save')
      project.reload
      expect(project.title).to eq('A rather small project')
    end
  end
end