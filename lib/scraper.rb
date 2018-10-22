require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".roster-cards-container .student-card")

    students.collect{|s|
      h = {:name => s.css("a h4").text,
      :location => s.css("a p").text,
      :profile_url => s.css("a").attribute("href").value}}
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    websites = profile.css(".social-icon-container a")
    h2 = {}
    binding.pry
    websites.each {|s|
      # v=URI.parse(s.attribute("href").value).host.gsub(".com", "")
      url=s.attribute("href").value
      v = URI.parse(url).host.gsub(".com", "").gsub("www.", "")
      # binding.pry
      h2[v.to_sym] = url
      }
      h2
  end

end
