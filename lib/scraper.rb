require 'open-uri'
# require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".roster-cards-container .student-card")
    student_cards.collect do |student_card|
      hash = {
        :name => student_card.css(".card-text-container h4").text,
        :location => student_card.css(".card-text-container p").text,
        :profile_url => "http://127.0.0.1:4000/" + student_card.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    social = doc.css(".main-wrapper.profile .vitals-container .social-icon-container a")
    social_links = social.collect do |link|
      link.attribute("href").value
    end
    social_links.collect do |item|
      element = item.split(/\/|\./)
      if element.include?("https:") || element.include?("www")
        element[2] != "www" ? hash_key = element[2].to_sym : hash_key = element[3].to_sym
        hash[hash_key] = item
      else
        hash[:blog] = item
      end
    end
    hash[:profile_quote] = doc.css(".main-wrapper.profile .vitals-container .vitals-text-container .profile-quote").text
    hash[:bio] = doc.css(".main-wrapper.profile .details-container .bio-block.details-block .bio-content.content-holder .description-holder p").text
    hash
  end

end

# Scraper.scrape_profile_page("http://127.0.0.1:4000/students/ryan-johnson.html")
