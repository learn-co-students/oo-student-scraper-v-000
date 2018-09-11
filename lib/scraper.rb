require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    kicks =  Nokogiri::HTML(open(index_url))

    students = []
    kicks.css(".student-card").collect { |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
      }
     }
     students
  end

  def self.scrape_profile_page(profile_url)
    kicks = Nokogiri::HTML(open(profile_url))
    profiles = []
    social_profiles = kicks.css(".social-icon-container").css("a").map{ |link| link.attribute("href").value}
    social_profiles.collect{|s|
      if s.include?("twitter")
      profiles << {
        :twitter => s
      } elsif s.include?("github")
      profiles << {
        :github => s
      } elsif s.include?("linkedin")
      profiles << {
        :linkedin => s
      } else s.include?("blog")
    profiles << {
      :blog => s
    }
    end
    }

    kicks.css(".vitals-container").collect{ |profile|
      profiles << {
        :profile_quote => profile.css(".vitals-text-container div.profile-quote").text,
        :bio => kicks.css(".description-holder").css("div p").text
        }
      }
      profiles.reduce Hash.new, :merge

  end

end
