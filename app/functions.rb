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
  
  # unless ActiveRecord::Base.connection.tables.include? 'friends'
  #   create_table :friends do |table|
  #     table.column :user_id, :integer
  #     table.column :name, :string
  #   end
  # end
end

class Title < ActiveRecord::Base
  # title - string
  # type - string
  
  # belongs_to :blogtemp
  
end

# class BlogTemp < ActiveRecord::Base
#   has_many :titles
# end