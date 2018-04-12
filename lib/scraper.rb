require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    profiles = doc.css(".student-card")
    profiles.each do |profile|
      fields = {}
      fields[:name] = profile.css(".student-name").text
      fields[:location] = profile.css(".student-location").text
      fields[:profile_url] = profile.css('a')[0]['href']
      students << fields
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    social_media = {}
    doc = Nokogiri::HTML(open(profile_url))
    keywords = %w(linkedin github twitter facebook)
    bio = doc.css(".description-holder p")
    social_media[:bio] = bio.text if !bio.empty?
    quote = doc.css(".profile-quote")
    social_media[:profile_quote] = quote.text if !quote.empty?
    links = doc.css(".social-icon-container a")
    links.each do |link|
      url = link['href']
      if url.include?("linkedin")
        social_media[:linkedin] = url
      elsif url.include?("github")
        social_media[:github] = url
      elsif url.include?("twitter")
        social_media[:twitter] = url
      elsif keywords.none? { |word| url.include?(word) }
        social_media[:blog] = url
      end
    end
    # binding.pry
    social_media
  end

end
