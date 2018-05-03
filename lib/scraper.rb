require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    names = doc.css(".student-name").map{|e| e.text}
    locations = doc.css(".student-location").map{|e| e.text}
    profile_urls = doc.css(".student-card a").map{|e| e.attributes["href"].value}

    students_array = []
    for i in 0..names.length
      students_array << { name: names[i], location: locations[i], profile_url: profile_urls[i]}
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}

    arr = doc.css(".social-icon-container a").each { |e|
      if e.attributes["href"].value =~ /twitter/
        student_hash[:twitter] = e.attributes["href"].value
      elsif e.attributes["href"].value =~ /linkedin/
        student_hash[:linkedin] = e.attributes["href"].value
      elsif e.attributes["href"].value =~ /github/
        student_hash[:github] = e.attributes["href"].value
      else
        student_hash[:blog] = e.attributes["href"].value
      end
    }
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text

    student_hash
  end

end
