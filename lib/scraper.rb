require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    split_url = index_url.split("/").slice(0,(index_url.split("/").size-1)).join("/")
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
      student_index_array << {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: "#{split_url}/#{student.css("a").attribute("href").value}"}
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-content .description-holder p").text
    doc.css(".social-icon-container a").each do |social_site|
      if social_site.css(".social-icon").attribute("src").value == "../assets/img/rss-icon.png"
        student_hash[:blog] = social_site.attribute("href").value
      elsif social_site.css(".social-icon").attribute("src").value == "../assets/img/linkedin-icon.png"
        student_hash[:linkedin] = social_site.attribute("href").value
      elsif social_site.css(".social-icon").attribute("src").value == "../assets/img/twitter-icon.png"
        student_hash[:twitter] = social_site.attribute("href").value
      elsif social_site.css(".social-icon").attribute("src").value == "../assets/img/github-icon.png"
        student_hash[:github] = social_site.attribute("href").value
      end # if elsif end
    end # do end
    student_hash
  end

end

# binding.pry
