require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".roster-cards-container .student-card")
      students.collect do |student|
        student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] =  student.css(".student-location").text
      student_hash[:profile_url] = student.css('a')[0]["href"]
      student_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      profile_hash = {}
      links = doc.css(".social-icon-container").children.css("a").collect{ |el| el.attribute('href').value}
      links.each do |link|
        if link.include?("twitter")
          profile_hash[:twitter] = link
        elsif link.include?("linkedin")
          profile_hash[:linkedin] = link
        elsif link.include?("github")
          profile_hash[:github] = link
        else
          profile_hash[:blog] = link
        end
      end
      profile_hash[:profile_quote] = doc.css(".profile-quote").text
      profile_hash[:bio] = doc.css(".description-holder p").text
      profile_hash
  end

end

#profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
