require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    nok = Nokogiri::HTML(html)
    output = []
    nok.css("div.roster-cards-container").each do |g|
      g.css(".student-card a").each do |s|
        scrape_name = s.css('.student-name').text
        scrape_location = s.css('.student-location').text
        scrape_profile_link = "http://127.0.0.1:4000/#{s.attr('href')}"
        output << {name: scrape_name, location: scrape_location, profile_url: scrape_profile_link }
      end
    end
    output
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    nok = Nokogiri::HTML(html)
    hold = nok.css(".social-icon-container")
    output = {}
    href = hold.css("a").map do |link|
      if (href = link.attr("href")) && href.match(/^https?:/)
        href
      end
    end
    href.each do |link|
      if link.include?("linked")
        output[:linkedin] = link
      elsif link.include?("git")
        output[:github] = link
      elsif link.include?("twit")
        output[:twitter] = link
      else
        output[:blog] = link
      end

    end

    qoute_scrape = nok.css(".vitals-text-container")
    check = qoute_scrape.css(".profile-quote").text
    output[:profile_quote] = check
    output[:bio] = nok.css("div.bio-content.content-holder div.description-holder p").text
    output
  end

end
