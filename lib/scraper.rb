require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".main-wrapper.roster .student-card").collect do |student_card|
      name = student_card.css("h4").text
      location = student_card.css(".student-location").text
      profile_url = student_card.css("a").attribute("href").value
      {name: name, location: location, profile_url: profile_url}
    end
  end

  def self.scrape_profile_page(profile_url)
    html = File.open(profile_url)
    doc = Nokogiri::HTML(html)
    values = {}
    doc.css(".vitals-container a").each do |link_data|
      link = link_data.attribute('href').value
      if link.include?('twitter')
        key = :twitter
      elsif link.include?('facebook')
        key = :facebook
      elsif link.include?('linkedin')
        key = :linkedin
      elsif link.include?('github')
        key = :github
      else
        key = :blog
      end
      values[key] = link
    end
    values[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    values[:bio] = doc.css(".details-container .description-holder p").text
    values
  end
end
