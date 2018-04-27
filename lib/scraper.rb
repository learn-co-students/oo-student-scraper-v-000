require pry
require_relative '../config.rb'


class Scraper

  def self.scrape_index_page(index_url)
    rtn = []

    page = Nokogiri::HTML(open(index_url))
    cards = page.css(".student-card")
    cards.each do |card|
      add = {}
      add[:name] = card.css(".student-name").text
      add[:location] = card.css(".student-location").text
      add[:profile_url] = card.css("a").attribute('href').to_s
      rtn << add
    end
    rtn
  end

  def self.scrape_profile_page(profile_url  = "http://159.89.225.105:46862/fixtures/student-site/students/heber-sandoval.html")
    rtn = {}

    page = Nokogiri::HTML(open(profile_url))
    social_links = page.css(".vitals-container").css("a")

    social_links.each do |link|
      href = link.css("a").attribute('href').to_s

      key = link_type(href)
      rtn[key] = href
    end
    rtn
  end
private

  def link_type(link_text)
    return :twitter if link_text.match?(/\A^http:\/\/.?twitter.com\/[.]*/)
    return :github if link_text.match?(/\A^http:\/\/.?github.com\/[.]*/)
    return :linkedin if link_text.match?(/\A^http:\/\/.?linkedin.com\/[.]*/)
  end
end
