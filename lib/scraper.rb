require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    kicks =  Nokogiri::HTML(open(index_url))

    # students = []
    kicks.css(".student-card").collect { |student|
      {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
      }
     }
     # students
  end

  def self.scrape_profile_page(profile_url)
    kicks = Nokogiri::HTML(open(profile_url))
    profile = {}
    social_profiles = kicks.css(".social-icon-container").css("a").map{ |link| link.attribute("href").value}

    social_profiles.collect{|s|
      if s.include?("twitter")
        profile[:twitter] = s
       elsif s.include?("github")
        profile[:github] = s
       elsif s.include?("linkedin")
        profile[:linkedin] = s
       else s.include?("blog")
        profile[:blog] = s
      end
    }

    profile[:profile_quote] = kicks.css(".vitals-container").css(".vitals-text-container div.profile-quote").text
    profile[:bio] = kicks.css(".description-holder").css("div p").text

    profile

  end

end
