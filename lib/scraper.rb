require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #open the URL
    doc = Nokogiri::HTML(open(index_url))
    #created an array
    scraped_students = []
    #iterate
    doc.css("div.student-card").each do |info|
      #hash
      student_hash = Hash.new

      student_hash[:name] = info.css(".student-name").text
      student_hash[:location] = info.css(".student-location").text
      student_hash[:profile_url] = info.css("a").attr("href").value

      #finish iteration and shovels into array
      scraped_students << student_hash
    end
    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_students = []
    student_hash = Hash.new

    doc.css('.vitals-container .social-icon-container a').each do |social|
      if social.css('img').attr('src').value.include?("twitter")
        student_hash[:twitter] = social.attr('href')
      elsif social.css('img').attr('src').value.include?("linkedin")
        student_hash[:linkedin] = social.attr('href')
      elsif social.css('img').attr('src').value.include?("github")
        student_hash[:github] = social.attr('href')
      elsif social.css('img').attr('src').value.include?("rss")
        student_hash[:blog] = social.attr('href')
      end
    end

    doc.css('html').each do |details|
      student_hash[:profile_quote] = doc.css(".profile-quote").text.strip
      student_hash[:bio] = doc.css(".description-holder").css("p").text
    end
    student_hash
  end

end
