require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    hash_ary_all = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".roster-cards-container .student-card")
    students.each do |student|
      hash = {:name => student.css(".card-text-container h4").text, :location => student.css(".card-text-container p").text, :profile_url => student.css("@href").first.value}
      hash_ary_all << hash
    end
    hash_ary_all
  end

  def self.scrape_profile_page(profile_url)
    hash_ary_single = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    #binding.pry
    icons = doc.css(".vitals-container .social-icon-container @href")
    bio = doc.css(".details-container .bio-block .bio-content .description-holder p").text
    quote = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    hash_ary_single = {:twitter => icons[0].text, :linkedin => icons[1].text, :github => icons[2].text, :blog => icons[3].text, :bio => bio, :profile_quote => quote}
    hash_ary_single
  end

end
