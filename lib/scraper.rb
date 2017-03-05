require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    scraped_students= []
    student = {}
    site = index_url.split("index.html")
    page.css("div.student-card a").each do |student|
      scraped_students << {:name => student.css("h4").text,
        :location => student.css("p").text, :profile_url => site[0] + student.attribute("href").value}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    social = page.css("div.social-icon-container a")
    student = {}
    array = []
    array = social.collect { |a| a.attribute("href").value}
    array.each do |site|
      if site.include?("twitter")
        student[:twitter] = site
      elsif site.include?("linkedin")
        student[:linkedin] = site
      elsif site.include?("github")
        student[:github] = site
      else
        student[:blog] = site
      end
    end
    student[:profile_quote] = page.css("div.profile-quote").text
    student[:bio] = page.css("div.description-holder p").text 
    student
  end

end
