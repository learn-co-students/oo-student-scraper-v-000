require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css(".student-card").each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_hash = {}
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-content .description-holder p").text

    doc.css(".social-icon").each do |icon|
      if icon.attribute("src").value.include?("twitter")
        student_hash[:twitter] = icon.parent.attribute("href").value
      elsif icon.attribute("src").value.include?("linkedin")
        student_hash[:linkedin] = icon.parent.attribute("href").value
      elsif icon.attribute("src").value.include?("github")
        student_hash[:github] = icon.parent.attribute("href").value
      elsif icon.attribute("src").value.include?("rss")
        student_hash[:blog] = icon.parent.attribute("href").value
      end
    end

    student_hash
  end
end
