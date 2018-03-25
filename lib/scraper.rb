require 'open-uri'
class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css(".student-card").each do |student|
      student = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute('href').to_s
      }
      scraped_students << student
    end
    scraped_students
    end
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    profile.css(".social-icon-container").css("a").map{|attribute|attribute["href"]}.each do |social|
      if social.include?("twitter")
        profile_hash[:twitter] = social
      elsif social.include?("linkedin")
          profile_hash[:linkedin] = social
      elsif social.include?("github")
          profile_hash[:github] = social
      elsif social.include?("http") && !social.include?("youtube") && !social.include?("facebook")
        profile_hash[:blog] = social
      end
    end
    quote = profile.css(".profile-quote").text.gsub(/\n/, "")
    bio = profile.css(".description-holder").css("p").text.gsub(/\n/, "")
    if quote
      profile_hash[:profile_quote] = quote
    end
    if bio
      profile_hash[:bio] = bio
    end
    profile_hash
  end
end
