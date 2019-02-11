require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")

    student_card.each do |student|
      students << {:name => "#{student.css(".student-name").text}",
      :location => "#{student.css(".student-location").text}",
      :profile_url => "#{student.css("a").first['href']}"}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    icons = []
    doc = Nokogiri::HTML(open(profile_url))
    social_icon_container = doc.css(".social-icon-container")

    social_icon_container.each do |student|
      icons << {:twitter => "#{student.css("a").first['href']}", #good
      :linkedin => "#{student.css(".student-location").text}",
      :github => "#{student.css("a").first['href']}",
      :blog => "#{student.css("a").first['href']}",
      :profile_quote => "#{student.css(".profile-quote").text}", #good
      :bio => "#{student.css("description-holder").text}"} #good
    end
    binding.pry
    icons
  end

end
