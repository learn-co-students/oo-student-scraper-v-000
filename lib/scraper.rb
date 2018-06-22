require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    
    doc.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        student_details = {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => student.attr("href")}
        students << student_details
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_social= {}
    doc = Nokogiri::HTML(open(profile_url))
    anchors = doc.css("a[href]")
    urls = anchors.map {|link| link["href"]}
    quote = doc.css("div.profile-quote")
    bio = doc.css("div.description-holder p")
    urls.each do |url|
      if url.include?("twitter")
        student_social.store(:twitter, url)
      elsif url.include?("linkedin")
        student_social.store(:linkedin, url)
      elsif url.include?("github")
        student_social.store(:github, url)
      elsif url.include?(".com")
        student_social.store(:blog, url)
      end
    end
      student_social.store(:profile_quote, quote.text)
      student_social.store(:bio, bio.text)
      student_social
  end

end

