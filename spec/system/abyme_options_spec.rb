require "rails_helper"

RSpec.describe "Partials default & custom path", type: :system do
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

RSpec.describe "Render error feedback", type: :system do
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