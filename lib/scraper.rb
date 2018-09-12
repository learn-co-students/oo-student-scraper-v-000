require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  index_page = Nokogiri::HTML(open(index_url)) 
  students = []
  index_page.css(".student-card a").each do |card|
    profile_link = card.attr("href")
    student_name = card.css(".student-name").text
    student_location = card.css(".student-location").text
    students << {:name =>student_name, :location =>student_location, :profile_url => profile_link}
  end
  students
 end
  def self.scrape_profile_page(profile_url)
 profile_html = open(profile_url)
    profile_doc = Nokogiri::HTML(profile_html)
    attributes = {}
    profile_doc.css("div.social-icon-container a").each do |link_xml|
      case link_xml.attribute("href").value
      when /twitter/
        attributes[:twitter] = link_xml.attribute("href").value
      when /github/
        attributes[:github] = link_xml.attribute("href").value
      when /linkedin/
        attributes[:linkedin] = link_xml.attribute("href").value
      else
          attributes[:blog] = link_xml.attribute("href").value
      end
    end
    attributes[:profile_quote] = profile_doc.css("div.profile-quote").text
    attributes[:bio] = profile_doc.css("div.bio-content div.description-holder").text.strip
    attributes
  end
end