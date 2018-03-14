require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card a").each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_link = "./fixtures/student-site/#{card.attr('href')}"

      students << {name: student_name, location: student_location, profile_url: student_link}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    @social_hash = {}
    profile = Nokogiri::HTML(open(profile_url))
    profile.css(".social-icon-container a").each do |icon|
      if icon.attr("href").include?("twitter")
        @twitter_link = icon.attr("href")
        @social_hash[:twitter] = @twitter_link
      elsif icon.attr("href").include?("linkedin")
        @linkedin_link = icon.attr("href")
        @social_hash[:linkedin] = @linkedin_link
      elsif icon.attr("href").include?("github")
        @github_link = icon.attr("href")
        @social_hash[:github] = @github_link
      elsif icon.attr("href").include?("twitter") == false && icon.attr("href").include?("linkedin") == false && icon.attr("href").include?("github") == false
        @blog_link = icon.attr("href")
        @social_hash[:blog] = @blog_link
      end
    end
    @student_quote = profile.css(".profile-quote").text
    @social_hash[:profile_quote] = @student_quote
    @student_bio = profile.css(".bio-block p").text
    @social_hash[:bio] = @student_bio
    @social_hash
  end

end
