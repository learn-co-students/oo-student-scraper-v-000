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
      social.css(".vitals-text-container div").each do |quote|
        profile_quote = quote.css(".profile-quote").text
      end
      
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
        elsif social_type.include?("blog")
          blog = social_type
      
        media[:twitter] = twitter
        media[:linkedin] = linkedin
        media[:github] = github
        media[:youtube] = youtube
        media[:blog] = blog
        media[:profile_quote] = profile_quote
        end
        binding.pry
      end
      media
    end
  end

end

