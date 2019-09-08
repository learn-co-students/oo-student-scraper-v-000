require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_array = []
    doc.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.at("a").attributes["href"].value
      #binding.pry

      student_array.push(
      name: name,
      location: location,
      profile_url: profile_url
      )
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_hash = {}
    name = doc.css(".profile-name").text.downcase.split.join
    anchors = doc.css(".social-icon-container a")
    anchors.each do |a|
      if a["href"].include?("twitter")
        student_hash[:twitter]= a["href"]
      elsif a["href"].include?("linkedin")
        student_hash[:linkedin]= a["href"]
      elsif a["href"].include?("github")
        student_hash[:github]= a["href"]
      elsif a.css("img").attribute("src").value.include?("rss")
        student_hash[:blog]= a["href"]
      end
    end
    student_hash[:profile_quote]= doc.css(".profile-quote").text
    student_hash[:bio]= doc.css(".description-holder p").text

    #binding.pry

    student_hash


  end

end
