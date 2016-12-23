require 'open-uri'
require 'pry'

class Scraper

  def self.get_page(path)
    Nokogiri::HTML(open(path))
  end

  def self.get_cards(path)
    self.get_page(path).css('div.student-card')
  end

  def self.scrape_index_page(path)
    arr = []
    self.get_cards(path).each do |card|
      h = {
        name: card.css('h4.student-name').text,
        location: card.css('p.student-location').text,
        profile_url: "./fixtures/student-site/#{card.css('a').first.attribute("href").value}"
      }
      arr << h
    end
    arr
  end

  def self.scrape_profile_page(path)
    info = {}

    doc = self.get_page(path)
    a = doc.css(".vitals-container a")
    #binding.pry
    a.each_with_index do |tag,i|
      link = tag.attribute("href").value
      if link.include?("twitter")
        info[:twitter] = link
      elsif link.include?("linkedin")
        info[:linkedin] = link
      elsif link.include?("github")
        info[:github] = link
      else
        info[:blog] = link
      end
    end

    info[:profile_quote] = doc.css(".vitals-container .profile-quote").text
    info[:bio] = doc.css(".details-container .bio-content p").text
    info
  end

end
