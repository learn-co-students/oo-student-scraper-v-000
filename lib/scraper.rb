require 'open-uri'
require 'pry'

class Scraper

  ### page = Nokogiri::HTML(open(index_url))
  ### profiles = page.css("div.roster-cards-container")
  ###
  ### :name => profile.css(".student-card a .card-text-container .student-name").text
  ### :location => profile.css(".student-card a .card-text-container .student-location").text
  ### :profile_url => profile.css(".student-card a")[0]["href"]



  def self.scrape_index_page(index_url)
    scraped_students = []
    page = Nokogiri::HTML(open(index_url))
    profiles = page.css("div.roster-cards-container .student-card")
    profiles.each do |profile|
      #title = profile["id"].chomp("-card").gsub("-","_")
        #scraped_students[title.to_sym] = hash...
        scraped_students << {
          :name => profile.css("a .card-text-container .student-name").text,
          :location => profile.css("a .card-text-container .student-location").text,
          :profile_url => profile.css("a")[0]["href"]
        }
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |link|

      case
      when link["href"] =~ /twitter/ # uses Regexp
        student[:twitter] = link["href"]
      when link["href"].include?("linkedin") # uses #include?
        student[:linkedin] = link["href"]
      when link["href"].include?("github")
        student[:github] = link["href"]
      else
        student[:blog] = link["href"]
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text
    student
  end
end
