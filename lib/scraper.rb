require 'open-uri'
require 'pry'

class Scraper

  @array_of_hashes = []

  def self.scrape_index_page(index_url)
    html = open(index_url)
    site = Nokogiri::HTML(html)
    student = site.css(".student-card")
    #test = site.css(".student-card").first
    student.each do |card|
      name = card.css("h4").text
      location = card.css("p").text
      profile_url = card.css("a").attribute("href").text
      @array_of_hashes << {:name => name, :location => location, :profile_url => "./fixtures/student-site/#{profile_url}"}
    end
    @array_of_hashes
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    site = open(profile_url)
    html = Nokogiri::HTML(site)
    social = html.css(".social-icon-container")
    social.children.css("a").each do |x|
      if x.attribute("href").to_s.include?("twitter") == true
        profile_hash[:twitter] = x.attribute("href").to_s
      elsif x.attribute("href").to_s.include?("linkedin") == true
        profile_hash[:linkedin] = x.attribute("href").to_s
      elsif x.attribute("href").to_s.include?("github") == true
        profile_hash[:github] = x.attribute("href").to_s
      else profile_hash[:blog] = x.attribute("href").to_s
      end
    end
    profile_hash[:profile_quote] = html.css(".profile-quote").text
    profile_hash[:bio] = html.css(".description-holder p").text
    profile_hash
  end

end
