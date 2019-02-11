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
    bio_content_content_holder = doc.css("bio-content content-holder")
    details_container = doc.css("details-container")

    icons = {:twitter => "#{social_icon_container.css("a").first['href']}", #works
    :linkedin => "#{social_icon_container.css("a").text}",
    :github => "#{social_icon_container.css("a").text}",
    :blog => "#{social_icon_container.css("a").text}",
    :profile_quote => "#{bio_content_content_holder.css(".profile-quote").text}", #another group
    :bio => "#{details_container.css(".description-holder").text}"} #yet another group

    binding.pry

    icons
  end

end
