require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      visit new_user_registration_path
      within("form") do
        fill_in "Email", with: "fakeemail@test.com"
        fill_in "Password", with: "fakepassword"  
        fill_in "Password confirmation", with: "fakepassword"
        click_button "Sign up"
      end
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit new_user_registration_path
      within("form") do
        fill_in "Email", with: "fakeemail@test.com"
        fill_in "Password", with: "fakepassword"  
        fill_in "Password confirmation", with: "fakepassword"
        click_button "Sign up"
      end
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit new_user_registration_path
      within("form") do
        fill_in "Email", with: "fakeemail@test.com"
        fill_in "Password", with: "fakepassword"  
        fill_in "Password confirmation", with: "fakepassword"
        click_button "Sign up"
      end
      visit edit_project_path(project)
    end
    scenario "remove project" do
      visit projects_path
      click_link "Destroy"
      expect(Project.count).to eq(0)
    end
  end
end
