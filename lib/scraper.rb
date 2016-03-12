require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do  |student|
      name = student.css("div.card-text-container h4.student-name").text
      location = student.css("div.card-text-container p.student-location").text
      profile_url = index_url + student.css("a").attribute("href").value.to_s
      students << {:name => name, :location => location, :profile_url => profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    profile.css(".social-icon-container").each do |social|
      social.css("a").each do |link|
        if link.attribute("href").value.include?("twitter")
          scraped_student[:twitter] = link.attribute("href").value
        elsif link.attribute("href").value.include?("github")
          scraped_student[:github] = link.attribute("href").value
        elsif link.attribute("href").value.include?("linkedin")
          scraped_student[:linkedin] = link.attribute("href").value
        else
          scraped_student[:blog] = link.attribute("href").value
        end
        scraped_student[:profile_quote] = profile.css(".vitals-text-container").css(".profile-quote").text
        scraped_student[:bio] = profile.css(".details-container").css(".bio-block").css(".bio-content").css(".description-holder").css("p").text
      end
    end
    scraped_student
  end

end
