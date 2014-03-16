# This creates the database (if it doesn't already exist).
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => (ENV['RACK_ENV'] == "test") ? "./app/dbfiles/blogtest.db" : "./app/dbfiles/blog.db"
)

ActiveRecord::Base.logger = Logger.new(STDERR)

####################### Table Creation #######################

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'blog_contents'
    create_table :blog_contents do |table|
      table.column :html_div, :string
      table.column :h_level, :integer
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'titles'
    create_table :titles do |table|
      table.column :blog_content_id, :integer
      table.column :titlestring, :string
      table.column :titletype, :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'authors'
    create_table :authors do |table|
      table.column :first, :string
      table.column :last, :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'commenters'
    create_table :commenters do |table|
      table.column :article_id, :integer
      table.column :first, :string
      table.column :last, :string
      table.column :email, :string
      table.column :comment_text, :text
      table.column :date_commented, :datetime
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'articles'
    create_table :articles do |table|
      table.column :author_id, :integer
      table.column :blog_content_id, :integer
      table.column :category, :string
      table.column :article_title, :string
      table.column :date_posted, :datetime
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'sections'
    create_table :sections do |table|
      table.column :article_id, :integer
      table.column :section_title, :string
      table.column :section_body, :text
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'media'
    create_table :media do |table|
      table.column :section_id, :integer
      table.column :type, :string
      table.column :media_link, :string
      table.column :media_data, :binary
    end
  end

end

####################### Table Classes #######################

class BlogContent < ActiveRecord::Base
  # html_div - string
  # h_level - integer
  
  has_many :titles
  has_many :articles
end

class Title < ActiveRecord::Base
  # blog_content_id - integer
  # titlestring - string
  # titletype - string
  
  belongs_to :blog_content 
end

class Author < ActiveRecord::Base
  # first - string
  # last - string

  has_many :articles
end

class Commenter < ActiveRecord::Base
  # article_id - integer
  # first - string
  # last - string
  # email - string
  # comment_text - text
  # date_commented - datetime

  belongs_to :article
end

class Article < ActiveRecord::Base
  # author_id - integer
  # category - string
  # article_title - string
  # date_posted - datetime

  has_many :sections
  has_many :commenters
  belongs_to :author
  belongs_to :blog_content
end

class Section < ActiveRecord::Base
  # article_id - integer
  # section_title - string
  # section_body - text
  
  belongs_to :article
  has_many :media
end

class Medium < ActiveRecord::Base
  # section_id - integer
  # type - string
  # media_link - string
  # media_data - binary
  
  belongs_to :section
end