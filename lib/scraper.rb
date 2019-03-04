require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_webpage = Nokogiri::HTML(html)
    @student_info = [] 
    learn_webpage.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a")[0]['href']
      @student_info << {:name => name, :location => location, :profile_url => profile_url}
    end
    @student_info 
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_webpage = Nokogiri::HTML(html)
    social_hash = Hash.new 
    unless profile_webpage.css("div.social-icon-container a")[0]['href'].empty? 
      social_hash[:twitter] = profile_webpage.css("div.social-icon-container a")[0]['href']
    end
    unless profile_webpage.css("div.social-icon-container a")[1]['href'].empty? 
      social_hash[:linkedin] = profile_webpage.css("div.social-icon-container a")[1]['href']
    end
    unless profile_webpage.css("div.social-icon-container a")[2]['href'].empty? 
      social_hash[:github] = profile_webpage.css("div.social-icon-container a")[2]['href']
    end
    unless profile_webpage.css("div.social-icon-container a")[3]['href'].empty? 
      social_hash[:blog] = profile_webpage.css("div.social-icon-container a")[3]['href']
    end 
    unless profile_webpage.css("div.profile-quote").text.empty? 
      social_hash[:profile_quote] = profile_webpage.css("div.profile-quote").text
    end 
    unless profile_webpage.css("div.description-holder p").text.empty? 
      social_hash[:bio] = profile_webpage.css("div.description-holder p").text
    end 
    social_hash
  end

end

