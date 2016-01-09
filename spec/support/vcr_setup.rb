VCR.configure do |c|
  c.default_cassette_options = { :record => :new_episodes, :erb => true }

  # not important for this example, but must be set to something
  c.hook_into :webmock
  c.cassette_library_dir = 'cassettes'
end