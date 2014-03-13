require 'sinatra/base'

require_relative './functions'

class PLBlog < Sinatra::Base
  # NOTE: If have to embed app root directory in a directory string, use
  #       "#{<application's sinatra class>.settings.root}/...rest of directory structure"
  #  Example code:
  #    @script = Script.new("#{MadLib.settings.root}/scripts/script1.txt")
  
  # Helper methods
  helpers do

  end

  # Setup/common methods for all routes
  before do
    @nav_choice = "blog"

  end

  # Routes methods
  get "/" do

    erb :bloghome
  end
  
  get "/nav_menu_select" do   
    @nav_choice = params[:menu_selection]
    
    erb :bloghome
  end
  
  get "/search" do
    
  end
  
  get "/about" do
    
  end
  
  get "/contact_info" do
    
  end

end