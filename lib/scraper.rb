require 'open-uri'
require 'nokogiri'
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
    h2[:bio] = profile.css(".bio-block p").text
    h2[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text

    websites.each {|s|
      url = s.attribute("href").value
      v = URI.parse(url).host.gsub(".com", "").gsub("www.", "")
      binding.pry

      # v.include? "twitter", h2[v.to_sym] = url
      }
      h2

    # h2.each {|k,v|
    #   v.include?(profile.css(".profile-name").text.downcase.split.first) ? k = :blog : nil}
    #
    # binding.pry



  end
end
