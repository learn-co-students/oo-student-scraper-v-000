require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    index_page.css("div.student-card").map do |profile|
      {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").value
       }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    media = {}
    profile_page.css("div.social-icon-container a").each do |sns|
      url = sns.attribute("href").value
      if url.match(/twitter|linkedin|github/) == nil
        media[:blog] = url
      else
        key = url.match(/twitter|linkedin|github/)[0].to_sym
        media[key] = url
      end
    end
    media[:profile_quote] = profile_page.css("div.profile-quote").text
    media[:bio] = profile_page.css("div.description-holder p").text
    media
  end

end

# Scraper.scrape_index_page(index_url)
# # => [
# {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
# {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
# {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"},
# {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "./fixtures/student-site/students/lorenzo-oro.html"},
# {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "./fixtures/student-site/students/marisa-royer.html"}
# ]

# Scraper.scrape_profile_page(profile_url)
# # => {:twitter=>"http://twitter.com/flatironschool",
#       :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio=> "I'm a school"
#      }
