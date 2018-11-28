require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    [{:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"},
         {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"},
         {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "students/carlos-rodriguez.html"},
         {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "students/lorenzo-oro.html"},
         {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "students/marisa-royer.html"}
       ]

  end

  def self.scrape_profile_page(profile_url)
    # => {:twitter=>"http://twitter.com/flatironschool",
      :linkedin=>"https://www.linkedin.com/in/flatironschool",
      :github=>"https://github.com/learn-co,
      :blog=>"http://flatironschool.com",
      :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      :bio=> "I'm a school"
     }
  end
end
