require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    # responsible for scraping the index page that lists all of the students
    # array = [{:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"}]
    collection = []
    scraped_students = Nokogiri::HTML(open(index_url))
    scraped_students.css("div.roster-cards-container div.student-card").each do |student|
      attributes = {
          name: student.css("h4.student-name").text,
          location: student.css("p.student-location").text,
          # profile_url needs to be searched locally so attach the constructed path to its string directory
          profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").value}",
      }
      collection << attributes
    end
    collection
  end

  def self.scrape_profile_page(profile_url)
    # responsible for scraping an individual student's profile page to get further information about that student
    updated_collection = {}
    scraped_students = Nokogiri::HTML(open(profile_url))
    scraped_students.css("div.social-icon-container a").each do |student|
      #https://github.com/sparklemotion/nokogiri/wiki/Cheat-sheet
      #node.attribute('src') #=> Get the attribute node with name src
      anchor = student.attribute("href").text

      if anchor.include?("twitter")
        updated_collection[:twitter] = anchor
      elsif anchor.include?("linkedin")
        updated_collection[:linkedin] = anchor
      elsif anchor.include?("github")
        updated_collection[:github] = anchor
      else student.css("img")[0]["src"].include?("rss-icon")
        updated_collection[:blog] = anchor
      end
    end
    updated_collection[:profile_quote] = scraped_students.css("div.profile-quote").text
    updated_collection[:bio] = scraped_students.css("div.description-holder p").text

    updated_collection
  end
end
