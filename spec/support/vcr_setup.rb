VCR.configure do |c|  
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr/'
  c.default_cassette_options = { :record => :new_episodes, :erb => true }
  # your HTTP request service. 
  c.hook_into :webmock
end 