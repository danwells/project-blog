require 'pry'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

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
    # Add page title to database if it doesn't already exist
    pagetitle = Title.find_by_titletype("page")  
    if Title.find_by_titletype("page").nil?  
      title_string = "Programming Languages - Syntax Comparisons by Example"    
      Title.create({:titlestring => title_string, :titletype => "page"}) 
    end  
     
    @titles = Title.all
    @page_title = Title.find_by_titletype("page")
    @nav_choice = "blog"
    @prev_search = "--"    

    binding.pry

  end

  # Routes methods
  get "/" do
    erb :bloghome
  end
  
  post "/nav_menu_select" do   
    @nav_choice = params[:menu_selection]
    
    erb :bloghome
  end
  
  get "/search" do
    @prev_search = params[:search_text]
    
    erb :bloghome
  end
  
  get "/about" do
    
    erb :about, :layout => false
  end
  
  get "/contact_info" do
    
  end

end