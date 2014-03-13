require 'spec_helper'

# describe Script do
#   it "gets placeholders" do
#     script = Script.new("#{MadLib.settings.root}/scripts/script1.txt")
#     
#     expect(script.placeholders).to include(["fictional place"])
#   end
#   
#   it "replace placeholders with values from inputs" do
#     script = Script.new("#{MadLib.settings.root}/scripts/script1.txt")
#     
#     placeholder_values = {"fictional place" => "Disneyland"}
#     
#     paragraphs = script.generate_fun(placeholder_values) # Array
#     
#     expect(paragraphs[0]).to include("Disneyland")
#   end
# end