require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_student = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    the_student = Hash.new
    students.each do |each_student|

      the_student[:name] = each_student.css("h4.student-name").text
      the_student[:location] = each_student.css(".student-location").text
      the_student[:profile_url] = "./fixtures/student-site/#{each_student.css("a").attribute("href").value}"


      scraped_student << {:name => the_student[:name], :location => the_student[:location], :profile_url => the_student[:profile_url]}

    end

    scraped_student

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_icon = doc.css(".social-icon-container")
    social_links = []

      social_icon.css("a").each do |social|
        social_links << social.attribute("href").value
      end
      is_blog = doc.css("vitals-text-container h1").text
    profile_hash = {}

    social_links.each do |links|
       profile_hash[:twitter] = links if links.include?("twitter")
       profile_hash[:linkedin] = links if links.include?("linkedin")
       profile_hash[:github] = links if links.include?("github")
       profile_hash[:blog] = links if links.include?((doc.css("div.vitals-container h1").text.downcase.split.first)) unless links.include?("link") 
    end

      profile_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
      profile_hash[:bio] = doc.css(".description-holder p").text

    profile_hash

  end

end
