require "rails_helper"
RSpec.describe "Helper options" do
  describe "Partials default & custom path", type: :system do
    it 'should set the correct partial when path specified' do
      visit new_project_path
      add_tasks(1)
      element = page.find('.custom-partial')
      expect(element).should_not be_nil
    end
  
    it 'should set the correct partial when path not specified' do
      visit new_project_path
      fill_in('project_title', with: "A project with two tasks")
      fill_in('project_description', with: 'A project description')    
      add_tasks(1)
      click_on('Save')
      visit edit_project_path(Project.last)
      element = page.find('.default-partial')
      expect(element).should_not be_nil
    end
  end
  
  describe "Render error feedback", type: :system do
    it 'should render error feedback for main resource' do
      visit new_project_path
      fill_in('project_description', with: 'A project description')
      click_on('Save')
      save_and_open_page
      element = page.find('.error')
      expect(element).should_not be_nil
    end
  
    it 'should render error feedback for nested resources' do
      visit new_project_path
      fill_in('project_title', with: "A project with two tasks")
      fill_in('project_description', with: 'A project description')
      add_tasks(1)
      add_tasks_with_errors(1)
      click_on('Save')
      save_and_open_page
      element = page.find('.error')
      expect(element).should_not be_nil
    end
  end

  describe "HTML attributes for 'abyme-fields' & add/remove association", type: :system do
    it 'should create the correct id' do
      visit new_project_path
      element = page.find('#add-task')
      expect(element).should_not be_nil
    end
  
    it 'should create the correct classes' do 
      visit new_project_path
      click_on('add participant')
      element = page.find('.participant-fields')
      expect(element).should_not be_nil
    end
  
    it 'should add the base class "abyme--fields"' do
      visit new_project_path
      click_on('add participant')
      element = page.find('.abyme--fields')
      expect(element).should_not be_nil
    end
  
    it 'should set the correct inner text for the add association button' do
      visit new_project_path
      element = page.find('button', text: 'add participant')
      expect(element).should_not be_nil
    end

    it 'should not create more than 3 tasks' do
      visit new_project_path
      4.times { click_on('Add task') }
      task_fields = []
      within('#abyme--tasks') { task_fields = all('.abyme--fields') }
      expect(task_fields.length).to eq(3)
    end
  end
end