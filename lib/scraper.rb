require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :students

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open(index_url)
    #html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").collect do |card|
      scraped_students << {
            :name => card.css("h4.student-name").text,
            :location => card.css("p.student-location").text,
            :profile_url => card.css("a").attribute("href").value
          }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_students_profiles = {}
    profile_html = open(profile_url)
    profile_doc = Nokogiri::HTML(profile_html)
    profile_doc.css("div.social-icon-container a").each do |link|
      case link.attribute("href").value
      when /twitter/
        scraped_students_profiles[:twitter] = link.attribute("href").value
      when /linkedin/
        scraped_students_profiles[:linkedin] = link.attribute("href").value
      when /github/
        scraped_students_profiles[:github] = link.attribute("href").value
      else
        scraped_students_profiles[:blog] = link.attribute("href").value
      end
    end
    scraped_students_profiles[:profile_quote] = profile_doc.css("div.profile-quote").text
    scraped_students_profiles[:bio] = profile_doc.css("div.bio-content div.description-holder p").text.strip
    scraped_students_profiles
  end


end
