require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".student-card a").each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_url = card.attr("href")
      student_array.push({:name => student_name, :location => student_location, :profile_url => student_url})
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    student_array = doc.css(".social-icon-container a").collect {|a_tag| a_tag.attr("href")}
    student_array.each do |href|
      if href.include?("twitter")
        student_profile[:twitter] = href
      elsif href.include?("linkedin")
        student_profile[:linkedin] = href
      elsif href.include?("github")
        student_profile[:github] = href
      else
        student_profile[:blog] = href
      end
    end
    student_profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_profile[:bio] = doc.css(".description-holder p").text
    student_profile
  end
end

