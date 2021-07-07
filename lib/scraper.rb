require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
      students = []
      doc.css(".student-card").each do |student|
      student_name = student.css(".student-name").first.text
      student_location = student.css(".student-location").first.text
      profile_url = student.css("a").first["href"]

      students << {
          :name => student_name, :location => student_location, :profile_url => profile_url
        }
      end
      students
    end




  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    social_links = doc.css(".social-icon-container").children.css("a").map { |link| link.attribute('href').value}
    social_links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
          student[:linkedin] = link
      elsif link.include?("github")
          student[:github] = link
      else
        student[:blog] = link
      end
    end

      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text

    student
  end
end
