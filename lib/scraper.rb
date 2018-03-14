require 'open-uri'
require 'pry'

class Scraper
  SOCIAL_SITES = [:twitter, :linkedin, :github]

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_cards = doc.css(".student-card")

    student_cards.collect do |card|
      url = "./fixtures/student-site/" + card.children[1].attributes['href'].value
      name = card.css(".student-name").text
      location = card.css(".student-location").text
      {name: name, location: location, profile_url: url}
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    social_links = doc.css(".social-icon-container a").collect do |a|
      a.attributes['href'].value
    end

    social = social_links.collect do |link|
      {clean_social(link).to_sym => link}
    end

    student_profile = test_social_links(social)

    student_profile[:bio] = doc.css(".description-holder p").text
    student_profile[:profile_quote] = doc.css(".profile-quote").text

    student_profile
  end

  private
  def self.clean_social(site)
    begin
      URI(site).host.chomp(".com").sub("www.", "")
    rescue
      "none"
    end
  end

  def self.test_social_links(links_to_test)
    result_hash = {}

    links_to_test.each do |link|
      link_key = link.keys.first

      if SOCIAL_SITES.include?(link_key)
        result_hash = result_hash.merge(link)
      else
        result_hash[:blog] = link[link_key]
      end
    end

    return result_hash
  end
end

