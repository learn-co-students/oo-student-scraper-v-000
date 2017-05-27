require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    html = open("fixtures/student-site/index.html")
	  doc = Nokogiri::HTML(html)
	  scraped_students = doc.css(".student-card")
    nodeset = doc.css('a[href]')
	  scraped_students.map do |student|
       student_hash = {}
       student_hash[:name]= student.css(".student-name").text
       student_hash[:location] = student.css(".student-location").text
       student_hash[:profile_url] = student.css("a").attr("href").value
       student_hash
    end
  end
  def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      doc = Nokogiri::HTML(html)
      #binding.pry
      scraped_student = {
        :profile_quote => doc.css(".vitals-container .vitals-text-container .profile-quote").text,
        :bio => doc.css(".details-container .bio-block .bio-content .description-holder p").text
      }
      socials = doc.css(".vitals-container .social-icon-container a")
      socials.each do |social|
      if social.attribute("href").value.include?("twitter")
        scraped_student[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        scraped_student[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        scraped_student[:github] = social.attribute("href").value
      else social.attribute("href").value.include?("blog")
        scraped_student[:blog] = social.attribute("href").value
      end
      end
      scraped_student
    end
end
