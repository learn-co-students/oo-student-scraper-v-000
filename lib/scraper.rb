require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    profile = doc.css(".roster-cards-container .student-card a")
    profile.each do |e|
    results <<  {:name => e.css(".student-name").text, :location => e.css(".student-location").text, :profile_url => "./fixtures/student-site/" + (e.attr("href"))}
    end
    results
  end

  def self.scrape_profile_page(profile_url)
    results = {}
    doc = Nokogiri::HTML(open(profile_url))
    profile = doc.css('.social-icon-container a')

      profile.select do |icon|
        social = icon.attr('href')
        social.include?("//www.") ? social = social.split("//www.")[1].split(".")[0].to_sym : social = social.split("//")[1].split(".com")[0].to_sym
        social = :blog if social != :twitter && social != :github && social != :linkedin && social != :youtube
        social_url = icon.attr('href')
        results[social] = social_url
      end
      pq = doc.css('.profile-quote').text
      results[:profile_quote] = pq
      ds = doc.css('.description-holder p').text
      results[:bio] = ds
      results

  end

end
