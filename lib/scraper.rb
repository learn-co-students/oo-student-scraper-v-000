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
      add[:url] = card.css("a").attribute('href').to_s
      rtn << add
    end
    rtn
  end

  def self.scrape_profile_page(profile_url)

  end

end
