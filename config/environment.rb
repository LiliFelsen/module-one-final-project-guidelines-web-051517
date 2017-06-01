require 'bundler/setup'
Bundler.require

 require 'active_record'
 require 'rake'
#
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}
#
# DBRegistry[ENV["BUDGETING_APP"]].connect!
# DB = ActiveRecord::Base.connection
#
# if ENV["BUDGETING_APP"] == "test"
#   ActiveRecord::Migration.verbose = false
# end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
