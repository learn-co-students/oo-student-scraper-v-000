require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  # cards: profile == index_page.css("div.roster-cards-container div.student-card")
  # name: profile.css("h4.student-name").text
  # location: profile.css("p.student-location").text
  # profile_url: profile.css("div.student-card a")['href']

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read(index_url))
    profiles = index_page.css("div.roster-cards-container div.student-card")
    students = []
    profiles.each do |profile|
      students << {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").first['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # profile_quote: profile_page.css("div.profile-quote").text
    # bio: profile_page.css("div.description-holder p").text

    profile_page = Nokogiri::HTML(File.read(profile_url))

    profile_hash = {
      :bio => profile_page.css("div.description-holder p").text,
      :profile_quote => profile_page.css("div.profile-quote").text
    }
    social_accts = profile_page.css("div.social-icon-container a")
    social_accts.each do |x|
      if x['href'].include? "twitter"
        profile_hash[:twitter] = x['href']
      elsif x['href'].include? "linkedin"
        profile_hash[:linkedin] = x['href']
      elsif x['href'].include? "github"
        profile_hash[:github] = x['href']
      elsif x['href'].include? "facebook"
        profile_hash[:facebook] = x['href']
      else
        profile_hash[:blog] = x['href']
      end
    end
    profile_hash
  end

end

Scraper.scrape_profile_page("./fixtures/student-site/students/adam-fraser.html")
