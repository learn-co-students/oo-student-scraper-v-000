require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page_doc = Nokogiri::HTML(html)
    students = []
    index_page_doc.css("div.roster-cards-container .student-card").each { |student| students << { name: student.css(".card-text-container .student-name").text, location: student.css(".card-text-container .student-location").text, profile_url: "./fixtures/student-site/" + student.css("a").attribute("href").value } }
    students
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page_doc = Nokogiri::HTML(html)
    link_array = []
    links = profile_page_doc.css(".social-icon-container")
    links.css("a").each { |url| link_array << url.attribute("href").value }
    info = {
      twitter: link_array.find { |url| /twitter/.match(url) },
      linkedin: link_array.find { |url| /linkedin/.match(url) },
      github: link_array.find { |url| /github/.match(url) },
      blog: link_array.find { |url| !(/twitter/.match(url)) && !(/linkedin/.match(url)) && !(/github/.match(url)) },
      profile_quote: profile_page_doc.css(".vitals-text-container .profile-quote").text,
      bio: profile_page_doc.css(".description-holder p").text
    }
    info.each do |key, value|
      if value == nil
        info.delete(key)
      end
    end
  end
end
