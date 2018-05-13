require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card")
    students.each do |student|
      results << {:name => student.css(".student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").first["href"]}
    end
    results
  end

  def self.scrape_profile_page(profile_url)
    social_profile = []
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css(".social-icon-container").css("a")

      social.each do |link|
        

    binding.pry
  end
  end

end
