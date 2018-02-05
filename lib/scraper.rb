require 'open-uri'
require 'pry'
require 'Nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = []
    #name: student.first.css("div.student-card a").first.css("h4.student-name").text
    #location: student.first.css("div.student-card a").first.css("p.student-location").text
    #profile-link: student.first.css("div.student-card a").first.attribute("href").value
    roster.css(".roster-cards-container .student-card a").each do |student|
      student_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.attribute("href").value
      }
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    # binding.pry
    profile_hash = {}
    profile.css(".social-icon-container a").each do |social|
      if social["href"].include?("twitter")
        profile_hash[:twitter] = social["href"]
      elsif social["href"].include?("linked")
        profile_hash[:linkedin] = social["href"]
      elsif social["href"].include?("github")
        profile_hash[:github] = social["href"]
      else
        profile_hash[:blog] = social["href"]
      end
    end
    profile_hash[:profile_quote] = profile.css(".profile-quote").text
    profile_hash[:bio] = profile.css(".bio-content p").text
    profile_hash
  end

end
# scrape = Scraper.new
# Scraper.scrape_profile_page('fixtures/student-site/students/ryan-johnson.html')
