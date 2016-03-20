require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	student_array = []

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.each do |student|
    	hash = Hash.new
    	hash[:name] = student.css(".student-name").text
    	hash[:location] = student.css(".student-location").text
    	student_site = student.css("a").attr("href").text
    	hash[:profile_url] = "http://127.0.0.1:4000/#{student_site}"
    	student_array << hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
  	hash = Hash.new

    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container a")
    hrefs = links.collect {|link| link.attr("href").to_s}

    hrefs.each do |link|
      if link.include?("twitter")
      	hash[:twitter] = link
      elsif link.include?("linkedin")
      	hash[:linkedin] = link
      elsif link.include?("github")
      	hash[:github] = link
      else
      	hash[:blog] = link
      end
    end

    hash[:profile_quote] = doc.css(".profile-quote").text.strip
    hash[:bio] = doc.css(".bio-content .description-holder").text.strip

    hash
  end

end

