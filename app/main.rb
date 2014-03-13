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

  end

  # Routes methods
  get "/" do

    erb :bloghome
  end
  
  get "/search" do
    
  end
  
  get "/about" do
    
  end
  
  get "/contact_info" do
    
  end

end