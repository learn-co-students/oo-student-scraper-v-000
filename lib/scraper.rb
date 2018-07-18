require 'pry'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students_array = []
    students = doc.css(".student-card")
    students.each do |student|
      student = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students_array << student
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}

    profile.css(".social-icon-container a").each do |link|
      url = link.attribute("href").text

      student[:twitter] = url if url.include?("twitter")
      student[:linkedin] = url if url.include?("linkedin")
      student[:github] = url if url.include?("github")
      student[:blog] = url if link.css("img").attribute("src").text.include?("rss")
    end
    student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = profile.css(".bio-content .description-holder p").text

    student
    #binding.pry
  end
end
