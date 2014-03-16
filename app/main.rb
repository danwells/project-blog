require 'pry'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class PLBlog < Sinatra::Base
  
  # Helper methods
  helpers do
    
    def add_to_titles(title, type)
      # Add a certain type of title to database if it doesn't already exist

      if Title.find_by(titlestring: title, titletype: type).nil?  
        Title.create({:titlestring => title, :titletype => type}) 
      end     
    end
    
    def add_initial_page_title 
      page_title = "Programming Languages - Syntax Comparisons by Example"    
      add_to_titles(page_title, "page")
      @titles = Title.all
      @page_title = Title.find_by_titletype("page")
    end
    
    def initialize_default_article(title)
      author = Author.find_or_create_by({:first => "Dan", :last => "Wells"})
      category = "Programming Languages"
      add_to_titles(category, "category")
      if Article.find_by_article_title(title).nil?
        Article.create({
          :author_id => author.id, 
          :blog_content_id => -1, 
          :category => category, 
          :article_title => title, 
          :date_posted => Time.now})
      end
      # @articles = Article.all
    end

    # l - languages array
    # a - the article to add the sections to
    def add_language_sections_to_article(l, a)
      l.each do |language|
        sec_title = "#{a.article_title} for (#{language})"
        sec_body = "Section text body for the #{language} language...."
        if Section.find_by(article_id: a.id, section_title: sec_title, section_body: sec_body).nil?
          a.sections.create({
            :section_title => sec_title, 
            :section_body => sec_body})
        end
      end
    
      binding.pry
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
    add_language_sections_to_article(languages, @current_article)
    
    # binding.pry
    
    
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