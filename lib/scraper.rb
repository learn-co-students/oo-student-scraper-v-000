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
    students = {}
    page = Nokogiri::HTML(open(index_url))
    profiles = page.css("div.roster-cards-container .student-card")
    #binding.pry
    profiles.each do |profile|
      title = profile["id"].chomp("-card").gsub("-","_")
      #title = Student.new(title)
        students[title.to_sym] = {
          :name => profile.css("a .card-text-container .student-name").text,
          :location => profile.css("a .card-text-container .student-location").text,
          :profile_url => profile.css("a")[0]["href"]
        }


    end
    Student.all << students
    #binding.pry
  end


  def self.scrape_profile_page(profile_url)

  end
end
