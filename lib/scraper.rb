require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_scrape = Nokogiri::HTML(open(index_url)).css("div.student-card")
    student_hash_index = []
    index_scrape.each do |student|
      student_hash_index<< {
        name: student.css("div.card-text-container h4.student-name").text,
        location: student.css("div.card-text-container p.student-location").text,
        profile_url: student.css("a").first["href"]
      }
    end



    student_hash_index
  end

  def self.scrape_profile_page(profile_url)
    profile_scrape = Nokogiri::HTML(open(profile_url)).css("div.main-wrapper.profile")

      student_hash_profile = {}
      profile_scrape.each do |profile|
      social_links = profile.css("div div.social-icon-container a").map {|link| link.attribute("href").to_s}
      linkedin_link = social_links.find{|link| link.match(/.*\blinkedin.*/)}
      github_link = social_links.find{|link| link.match(/.*github.*/)}
      twitter_link = social_links.find{|link| link.match(/.*\btwitter.*/)}
      blog_link = social_links.find{|link| link != linkedin_link && link != github_link && link != twitter_link}
        student_hash_profile = {
          twitter: twitter_link,
          linkedin: linkedin_link,
          github: github_link,
          blog: blog_link,
          profile_quote: profile.css("div.vitals-text-container div.profile-quote").text,
          bio: profile.css("div.details-container div div div.description-holder p").text
        }.delete_if{|key,value| value == nil}

      end
      student_hash_profile
      end

end
