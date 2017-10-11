require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  # each student = doc.css(".student-card").first
  # name = doc.css(".student-card").first.css(".card-text-container h4").text
  # location = doc.css(".student-card").first.css(".card-text-container p").text
  # profile url = doc.css(".student-card").first.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    array = []

    doc.css(".student-card").each do |student_card|
      hash = {
        :name => student_card.css(".card-text-container h4").text,
        :location => student_card.css(".card-text-container p").text,
        :profile_url => student_card.css("a").attribute("href").value
       }
      array << hash
    end
    array
  end

  # twitter = doc.css(".social-icon-container a:nth-child(1)").attribute("href").value
  # linkedin = doc.css(".social-icon-container a:nth-child(2)").attribute("href").value
  # github = doc.css(".social-icon-container a:nth-child(3)").attribute("href").value
  # blog = doc.css(".social-icon-container a:nth-child(4)").attribute("href").value
  # profile_quote = doc.css(".profile-quote").text
  # bio = doc.css(".bio-block.details-block .description-holder").text.strip

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    hash = {}

    counter = 1
    while counter <= doc.css(".social-icon-container a").length
      link = doc.css(".social-icon-container a:nth-child(#{counter})").attribute("href").value
      if link.include?("twitter")
        hash[:twitter] = link
      elsif link.include?("linkedin")
        hash[:linkedin] = link
      elsif link.include?("github")
        hash[:github] = link
      else
        hash[:blog] = link
      end
      counter += 1
    end

    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css(".bio-block.details-block .description-holder").text.strip

    hash
  end

end
