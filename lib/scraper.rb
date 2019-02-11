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
    icons = {}
    doc = Nokogiri::HTML(open(profile_url))

    social_icon_container = doc.css(".social-icon-container")
    bio_content = doc.css(".bio-content")

    icons = {:twitter => "#{social_icon_container.css("a")[0]['href']}", #works
    :linkedin => "#{social_icon_container.css("a")[1]['href']}",
    :github => "#{social_icon_container.css("a")[2]['href']}",
    :blog => "#{social_icon_container.css("a")[3]['href']}",
    :profile_quote => "#{doc.css(".profile-quote").text}", #works
    :bio => "#{bio_content.css(".description-holder").css("p").text}"} #works
    icons
  end

end
