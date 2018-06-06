require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    student_ary = []
    doc = Nokogiri::HTML(open(index_url))
    index_page = doc.css(".roster-cards-container .card-text-container")
    index_page.each_with_index do |student, a_tag_num|
      hash = {}
      hash[:location] = student.css("p.student-location").text
      hash[:name] = student.css("h4.student-name").text
      hash[:profile_url] = doc.css("a")[a_tag_num+1]["href"]
      student_ary << hash
    end
    student_ary
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    doc = Nokogiri::HTML(open(profile_url))
    urls = doc.css(".social-icon-container a")
    urls.each do |link|
      if  link["href"].include?("twitter")
        profile[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        profile[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        profile[:github] = link["href"]
      elsif link["href"]
        profile[:blog] = link["href"]
      end
    end
    profile[:profile_quote] = doc.css(".vitals-text-container div.profile-quote").text
    profile[:bio] = doc.css(".details-container .description-holder p").text
    profile
  end
end
