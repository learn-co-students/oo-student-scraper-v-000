require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      index_url = "http://127.0.0.1:4000/"
      scraper_students = []
      student_hash = {}
      doc = Nokogiri::HTML(open(index_url))
      doc.css(".student-card").each do |student|
      	student_hash = {
      		:name => student.css("h4.student-name").text,
      		:location => student.css("p.student-location").text,
      		:profile_url => "http://127.0.0.1:4000/#{student.css("a").attr("href").value}"
      	}
      	scraper_students << student_hash
      end
 			scraper_students
  end

     
  def self.scrape_profile_page(profile_url)
      scraped_student = {}
      profile = Nokogiri::HTML(open(profile_url))
      social_size = profile.css(".social-icon-container a").size
      social_array = []
      i = 0
      while i < social_size
        social_array[i] = profile.css(".social-icon-container a")[i].attr("href")
        if social_array[i].include? "twitter"
          twitter = social_array[i]
        elsif social_array[i].include? "github"
          github = social_array[i]
        elsif social_array[i].include? "linkedin"
          linked_in = social_array[i]
        else
          blog = social_array[i]
        end
        i = i + 1
      end
      profile_quote = profile.css(".profile-quote").text
      bio = profile.css(".description-holder p").text 

      scraped_student = {
        :twitter => twitter,:linkedin => linked_in,:github => github,:blog => blog, :profile_quote => profile_quote,:bio => bio 
      }.reject { |k,v| v.nil? }
      scraped_student
  end



end



