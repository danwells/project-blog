# This creates the database (if it doesn't already exist).
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => (ENV['RACK_ENV'] == "test") ? "./app/dbfiles/blogtest.db" : "./app/dbfiles/blog.db"
)

ActiveRecord::Base.logger = Logger.new(STDERR)

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
      table.column :section_body, :string
    end
  end

end

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
  # section_body - string
  
  belongs_to :article
  has_many :media
end
