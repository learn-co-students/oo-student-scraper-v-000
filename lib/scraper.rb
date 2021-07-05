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
    icons = doc.css(".vitals-container .social-icon-container @href")
    icons.each do |icon|
      if icon.text.include?"twitter"
         hash_ary_single[:twitter] = icon.text
      elsif icon.text.include?"linkedin"
         hash_ary_single[:linkedin] = icon.text
      elsif icon.text.include?"github"
         hash_ary_single[:github] = icon.text
      elsif icon.text.include?"http"
         hash_ary_single[:blog] = icon.text
      end
    end
    hash_ary_single[:bio] = doc.css(".details-container .bio-block .bio-content .description-holder p").text
    hash_ary_single[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    hash_ary_single
  end
end
