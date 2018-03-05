require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :students, :student_card, :student_cards, :profile_url, :student_profile_xml
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    html = File.read('./fixtures/student-site/index.html')
    index_url = Nokogiri::HTML(html)

    student_cards = doc.css(".student-card")
    students = []
    student_cards.collect do |student_card|
    students << {
      name: student_card.css(".student-name").text,
      location: student_card.css(".student-location").text,
      profile_url: student_card.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    profile_doc = Nokogiri::HTML(profile_html)
    student_profiles = {}
    profile_doc.css("div.social-icon-container a").each do |student_profile_xml|
    case student_profile_xml.attribute("href").value
      when /linkedin/
        student_profiles[:linkedin] = student_profile_xml.attribute("href").value
      when /github/
        student_profiles[:github] = student_profile_xml.attribute("href").value
      when /twitter/
        student_profiles[:twitter] = student_profile_xml.attribute("href").value
      else
        student_profiles[:blog] = student_profile_xml.attribute("href").value
    end
    end
    student_profiles[:profile_quote] = profile_doc.css(".profile-quote").text
    student_profiles[:bio] = profile_doc.css("div.bio-content div.description-holder").text.strip
    student_profiles
  end

end
