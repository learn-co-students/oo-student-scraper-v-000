require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_hash = []
    html.css("div.roster-cards-container").each do |student|
      student.css(".student-card a").each do |stud|
        profile_url = "#{stud.attr("href")}"    
        name = stud.css(".student-name").text
        location = stud.css(".student-location").text
        student = {:name => name, :location => location, :profile_url => profile_url}
        student_hash << student
      end
    end
      student_hash
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    media = {}
    html.css("div.vitals-container").each do |social|
        
      profile_quote = social.css(".profile-quote").text
      bio = social.css("description-holder p").text
        binding.pry
      twitter, linkedin, github, youtube, blog = nil
      
      social.css(".social-icon-container a").each do |type|
        social_type = type.attr("href")
        if social_type.include?("twitter")
          twitter = social_type
        elsif social_type.include?("linkedin")
          linkedin = social_type
        elsif social_type.include?("github")
          github = social_type
        elsif social_type.include?("youtube")
          youtube = social_type
        else
          blog = social_type
        end
      end
      
    media[:twitter] = twitter
    media[:linkedin] = linkedin
    media[:github] = github
    media[:youtube] = youtube
    media[:profile_quote] = profile_quote
    media[:blog] = blog
    media[:bio] = bio
    end
  media
  end

end

