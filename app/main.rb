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
    
    def add_initial_page_title 
      # Add page title to database if it doesn't already exist
      if Title.find_by_titletype("page").nil?  
        title_string = "Programming Languages - Syntax Comparisons by Example"    
        Title.create({:titlestring => title_string, :titletype => "page"}) 
      end     
      @titles = Title.all
      @page_title = Title.find_by_titletype("page")
    end
    
    def initialize_default_article(title)
      if Article.find_by_article_title(title).nil?
        author = Author.find_or_create_by({:first => "Dan", :last => "Wells"})
        category = "Programming Languages"
        Article.create({
          :author_id => author.id, 
          :blog_content_id => -1, 
          :category => category, 
          :article_title => title, 
          :date_posted => Time.now})
      end
      # @articles = Article.all
    end

  end

  # Setup/common methods for all routes
  before do
    add_initial_page_title
    @nav_choice = "blog"
    @prev_search = "--"    

    default_title = "The Variable Assignment Statement"
    initialize_default_article(default_title)
    @current_article = Article.find_by_article_title(default_title)
    
    languages = ["JavaScript", "Java", "PHP", "C#", "Python", "C/C++", "Ruby", "Objective-C"]
    # if Section.count < languages.count
      languages.each do |language|
        @current_article.sections.create({
          :section_title => "#{default_title} for (#{language})", 
          :section_body => "Section text body for the #{language} language...."})
        # Section.create({:article_id => -1, :section_title => language, :section_body => ""})
      end
    # end

    binding.pry
    
    
  end

  # Routes methods
  get "/" do
    erb :bloghome
  end
  
  post "/nav_menu_select" do   
    @nav_choice = params[:menu_selection]
    case @nav_choice
    when "toc"
      erb :toc, :layout => false
    when "browse"
      erb :browse, :layout => false
    when "options"
      erb :options, :layout => false
    else
      erb :bloghome
    end
  end
  
  get "/search" do
    @prev_search = params[:search_text]
    
    erb :bloghome
  end
  
  get "/about" do
    
    erb :about, :layout => false
  end
  
  get "/contact_info" do
    
    erb :contact
  end

end