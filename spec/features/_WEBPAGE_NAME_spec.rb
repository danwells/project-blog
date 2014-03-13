require 'spec_helper'

# describe "Mad Lib", :type => :feature do
#   it "shows fields for the mad lib" do
#     visit("/")
#     expect(page).to have_content("Enter values for the following fields")
#   end
#   
#   it "people fill out fields and submit form" do
#     visit ("/")
#     
#     within('#placeholders') do
#       fill_in('fun event', :with => 'Disneyland')
#       click_button('Submit')
#     end
#     
#     expect(page).to have_content("Script")
#   end
#   
#   it "shows the full script with the submitted values" do
#     visit ("/")
#     
#     within('#placeholders') do
#       fill_in('fun event', :with => 'Disneyland')
#       click_button('Submit')
#     end
#     
#     expect(page).to have_content("Disneyland")
#   end
# end