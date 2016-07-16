require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    student_cards = Nokogiri::HTML(open(index_url)).css(".student-card")
    students = []
    student_cards.map do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile = "./fixtures/student-site/" + student.css("a")[0]["href"]
      students << {name: name, location: location, profile_url: profile}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    social_icons = student.css(".social-icon-container a")
    social_icons.each do |social|
      if social["href"].include?("twitter")
        student_hash[:twitter] = social["href"]
      elsif social["href"].include?("linkedin")
        student_hash[:linkedin] = social["href"]
      elsif social["href"].include?("github")
        student_hash[:github] = social["href"]
      else
        student_hash[:blog] = student.css(".social-icon-container a").last["href"]
      end
    end
    student_hash[:profile_quote] = student.css(".vitals-text-container .profile-quote").text
    student_hash[:bio] = student.css(".bio-content p").text
    student_hash
  end

end

