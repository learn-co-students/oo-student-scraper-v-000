#require pry
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
    #binding.pry

    social_links.each do |link|
      href = link.attribute('href').to_s

      key = self.link_type(link)
      rtn[key] = href
    end

    quote = page.css(".vitals-text-container").css(".profile-quote").text
    rtn[:profile_quote] = quote

    bio = page.css(".bio-content content-holder").css(".description-holder").css("p").text
    rtn[:bio] = bio

    rtn
  end

private
  def self.link_type(link)
    uniq = link.css("img").attribute('src').value.to_s

    return :twitter if !!uniq.match(/\A^.*twitter-icon\.png$\z/i)
    return :github if !!uniq.match(/\A^.*github-icon\.png$\z/i)
    return :linkedin if !!uniq.match(/\A^.*linkedin-icon\.png$\z/i)
    return :blog if !!uniq.match(/\A^.*rss-icon\.png$\z/i)
    nil
  end
end
