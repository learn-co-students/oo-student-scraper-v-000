require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    return_array_of_hash = []



    return_array_of_hash
    # [
    #     {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
    #     {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
    #     {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"},
    #     {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "./fixtures/student-site/students/lorenzo-oro.html"},
    #     {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "./fixtures/student-site/students/marisa-royer.html"}
    #   ]
  end

  def self.scrape_profile_page(profile_url)
    return_hash = {
      :twitter=>"",
      :linkedin=>"",
      :github=>"",
      :blog=>"",
      :profile_quote=>"",
      :bio=> ""
    }


    return_hash
    # {:twitter=>"http://twitter.com/flatironschool",
    #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
    #   :github=>"https://github.com/learn-co,
    #   :blog=>"http://flatironschool.com",
    #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #   :bio=> "I'm a school"
    #  }
  end

end
