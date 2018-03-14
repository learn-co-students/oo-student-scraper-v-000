require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").collect do |student|
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    profile_hash = {}
    profile.css("div .social-icon-container a").each do |profile|
      if profile.attribute("href").value.include? "twitter"
        profile_hash[:twitter] = profile.attribute("href").value
      elsif profile.attribute("href").value.include? "linkedin"
        profile_hash[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include? "github"
        profile_hash[:github] = profile.attribute("href").value
      elsif profile.attribute("href").value.include? "facebook"
        profile_hash[:facebook] = profile.attribute("href").value
      else
        profile_hash[:blog] = profile.attribute("href").value
      end
    end
    profile_hash[:profile_quote] = profile.css("div .profile-quote").text
    profile_hash[:bio] = profile.css("div .bio-content .description-holder p").text
    profile_hash
  end
end

    # social media links profile.css("div .social-icon-container a")
      # :twitter
      # :linkedin
      # :github
      # :blog
      # :profile quote
      # :bio
