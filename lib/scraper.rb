require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    array_of_hashes = []
    doc = Nokogiri::HTML(open(index_url))
    doc.search(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.search("h4").text
      student_hash[:location] = student.search("p").text
      student_hash[:profile_url] = "./fixtures/student-site/" << student.search("a")[0]["href"]
      array_of_hashes << student_hash
    end
    array_of_hashes
  end

  def self.scrape_profile_page(profile_url)
    student_profile_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    all_social_links = doc.search(".social-icon-container a")
    url_array = all_social_links.map {|link| link["href"]}
    url_array.each do |url|
      url_parts = url.split(/\.|\//)
      if url_parts.include?("twitter")
        student_profile_hash[:twitter] = url
      elsif url_parts.include?("linkedin")
        student_profile_hash[:linkedin] = url
      elsif url_parts.include?("github")
        student_profile_hash[:github] = url
      else
        student_profile_hash[:blog] = url
      end
    end
    student_profile_hash[:profile_quote] = doc.search(".profile-quote").text
    student_profile_hash[:bio] = doc.search("p").text
    student_profile_hash
  end
end
