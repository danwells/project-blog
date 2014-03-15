# This creates the database (if it doesn't already exist).
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => (ENV['RACK_ENV'] == "test") ? "./app/dbfiles/blogtest.db" : "./app/dbfiles/blog.db"
)

ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'titles'
    create_table :titles do |table|
      table.column :titlestring, :string
      table.column :titletype, :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'blog_contents'
    create_table :blog_contents do |table|
      table.column :title_id, :integer
      table.column :html_div, :string
      table.column :h_level, :integer
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'sections'
    create_table :sections do |table|
      table.column :section_title, :string
      table.column :section_body, :string
      table.column :media_id, :integer
    end
  end

end

class Title < ActiveRecord::Base
  # title - string
  # type - string
  
  belongs_to :blog_contents
  
end

class BlogContent < ActiveRecord::Base
  # title_id - integer
  # html_div - string
  # h_level - integer
  
  has_many :titles
end

class Section < ActiveRecord::Base
  # section_title - string
  # section_body - string
  # media_id - integer
  
 # belongs_to :articles
 # has_many :media
end
