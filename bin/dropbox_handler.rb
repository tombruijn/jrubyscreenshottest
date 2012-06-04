require 'yaml'
require 'rubygems'
require 'dropbox'
class DropboxHandler
  def upload()
    config = YAML::load(File.open('config.yaml'))
    # puts config.inspect
    db_config = config["dropbox"]
    # puts db_config.inspect
    # STEP 1: Authorize the user
    session = Dropbox::Session.new(db_config["app_key"], db_config["app_secret"],{:authorizing_user => db_config["email"], :authorizing_password => db_config["password"]})
    session.mode = :dropbox
    session.authorizing_user = db_config["email"]
    session.authorizing_password = db_config["password"]
    puts session.authorized?.inspect
    session.authorize!
    # 
    # , {:ssl => db_config["ssl"].to_bool, :authorizing_user => db_config["email"], :authorizing_password => db_config["password"] })
    # session.mode = :dropbox # might need to set this to :dropbox; consult your API account page
    # puts "Visit #{session.authorize_url} to log in to Dropbox. Hit enter when you have done this."
    # gets
    # session.authorize
    
    # STEP 2: Play!
    session.upload('selection_layer.rb', '/')
    uploaded_file = session.file('selection_layer.rb')
    puts uploaded_file.metadata.size
    # 
    # uploaded_file.move 'new_name.txt'
    # uploaded_file.delete
    # 
    # # STEP 3: Save session for later
    # File.open('serialized_session.txt', 'w') do |f|
    #   f.puts session.serialize
    # end
    # 
    # # STEP 4: Play with saved session!
    # new_session = Dropbox::Session.deserialize(File.read('serialized_session.txt'))
    # account = new_session.account
    # puts account.display_name
  end
end