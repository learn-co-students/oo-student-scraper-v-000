require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # responsible for scraping the index page that lists all of the students
    # array = [{:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"}]
    collection = []
    scraped_students = Nokogiri::HTML(open(index_url))
    scraped_students.css("div.roster-cards-container").each do |student|
      attributes = {
          name: student.css("h4.student-name").text.strip,
          location: student.css("p.student-location").text.strip,
          profile_url:student.css("a").attribute("href").value,
      }
      collection << attributes
    end
    collection
  end

  def self.scrape_profile_page(profile_url)
    # responsible for scraping an individual student's profile page to get further information about that student
    updt_coll = {}
    scraped_students = Nokogiri::HTML(open(profile_url))
    scraped_students.css("div.social-icon-container").each do |student|
      case student
        when student.attr("href").include?("twitter")
          updt_coll[:twitter] = student.attr("href")
        when student.attr("href").include?("linkedin")
          updt_coll[:linkedin] = student.attr("href")
        when student.attr("href").include?("github")
          updt_coll[:github] = student.attr("href")
        when student.attr("href").include?("blog")
          updt_coll[:blog] = student.attr("href")
      end
    end

    updt_coll[:profile_quote] = student.css("div.profile-quote").text
    updt_coll[:bio] = student.css("div.description-holder p").text

    updt_coll
  end
#binding.pry
end
