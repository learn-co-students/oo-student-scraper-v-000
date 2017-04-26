require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |student|
      students.push({
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => index_url.gsub("index.html","") + student.css("a").attribute("href").value
        })
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    hash = {}

    social = doc.css(".social-icon-container a")
    social.each do |a|
      address = a.attribute("href").value
      if address.include? "linkedin"
        hash[:linkedin] = address
      elsif address.include? "github"
        hash[:github] = address
      elsif address.include? "twitter"
        hash[:twitter] = address
      else
        hash[:blog] = address
      end
    end

    hash[:profile_quote] = doc.css("div.profile-quote").text
    hash[:bio] = doc.css(".bio-content .description-holder p").text

    hash
  end

end
