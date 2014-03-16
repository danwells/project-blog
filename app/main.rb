require 'pry'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class PLBlog < Sinatra::Base
  
  # Helper methods
  helpers do
    
    def add_to_titles(title, type)
      # Add a title to database if it doesn't already exist
      if Title.find_by(titlestring: title, titletype: type).nil?  
        Title.create({:titlestring => title, :titletype => type}) 
      end     
    end
    
    def add_initial_page_title 
      page_title = "Programming Languages - Syntax Comparisons by Example"    
      add_to_titles(page_title, "page")
    end
    
    def initialize_default_article(title)
      author = Author.find_or_create_by({:first => "Dan", :last => "Wells"})
      
      add_to_titles(title, "article")
      future_titles = [
        "The Increment Operation", 
        "The Conditional Statement", 
        "Loops", 
        "The Switch/Case Statement", 
        "Class Declaration and Object Instantiation"]
      future_titles.each do |title|
        add_to_titles(title, "future_article")
      end
      
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
        # Check for not adding a duplicate
        if Section.find_by(article_id: a.id, section_title: sec_title, section_body: sec_body).nil?
          a.sections.create({
            :section_title => sec_title, 
            :section_body => sec_body})
        end
      end    
      # binding.pry
    end
    
    def add_code_snippet_to_section(link, s) 
      if Image.find_by(section_id: s.id, img_type: "snippet", img_link: link).nil?    
        s.images.create({
          :img_type => "snippet",
          :img_link => link}) 
      end     
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
    
    js_sec = @current_article.sections.where("section_title LIKE ?", "%(#{languages[0]})%")[0]
    add_code_snippet_to_section("http://i.imgur.com/8WFZtua.png", js_sec)
    java_sec = @current_article.sections.where("section_title LIKE ?", "%(#{languages[1]})%")[0]
    add_code_snippet_to_section("http://i.imgur.com/sTUF2EC.png", java_sec)
    

    @page_title = Title.find_by_titletype("page")
    @future_titles = Title.where("titletype = ?", "future_article")
    @current_author = Author.find(@current_article.author_id)
    # @sections = Section.where("article_id = ?", @current_article.id)

    # binding.pry
        
  end

  after do
    ActiveRecord::Base.connection.close
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