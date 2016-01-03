require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    hashes = []
    
    html = Nokogiri::HTML(open(index_url))
    students = html.css(".student-card")

    students.each do |student|
      hash = {}
      hash[:name] = student.css(".card-text-container h4").text
      hash[:location] = student.css(".card-text-container p").text
      hash[:profile_url] = index_url + "/" + student.css("a").attribute("href").value
      hashes << hash
    end
    hashes

  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    
    html = Nokogiri::HTML(open(profile_url))

    socials_links = html.css(".social-icon-container").css("a")

    socials_links.each do |link|
      link = link.attribute("href").value
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end

    student_hash[:profile_quote] = html.css(".profile-quote").text
    student_hash[:bio] = html.css(".description-holder p").text
  
    student_hash
  end


end
