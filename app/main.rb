require 'sinatra/base'

require_relative './functions'

class PLBlog < Sinatra::Base
  # NOTE: If have to embed app root directory in a directory string, use
  #       "#{ToDoList.settings.root}/...rest of directory structure"
  
  # Helper methods
  helpers do

  end

  # Setup/common methods for all routes
  before do
    #Example code:
    #    @script = Script.new("#{MadLib.settings.root}/scripts/script1.txt")
  end

  # Routes methods
  get "/" do

  end

end