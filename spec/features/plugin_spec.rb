require 'spec_helper'

#Capybara.default_driver = :poltergeist
Capybara.default_driver = :selenium_chrome_headless
Capybara.app_host = "http://localhost:3000"
Capybara.server_host = "localhost"
Capybara.server_port = "3000"

RSpec.feature "My Plugin", type: :feature, with_settings: { login_required?: false } do

  let!(:admin) { FactoryGirl.create :admin }


    before do
      login_as(admin)
    end

    it "displays account creator plugin block in homescreen" do
      visit '/'
      expect(page).to have_content("Account Creator Plugin")
    end

    it "show the account creator plugin page" do
      visit '/accountcreators'
      expect(page).to have_button("Upload")
    end

    scenario "create the account successfully" do
      visit '/accountcreators'
      click_button 'Upload'
      expect(page).to have_content 'No file chosen!'
    end

end
