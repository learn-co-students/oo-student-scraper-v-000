require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").each do |example|
      hash = {}
      hash[:name] = example.css(".student-name").text
      hash[:location] = example.css(".student-location").text
      hash[:profile_url] = example.children[1].attributes["href"].value
      array << hash
    end
    return array
  end

  def self.scrape_profile_page(profile_url)
    array = []
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc = doc.css("div.main-wrapper.profile")
    hash = {}
    hash[:bio] = doc.css(".bio-block.details-block .description-holder").text.delete("\n").lstrip.rstrip
    hash[:profile_quote] = doc.css(".vitals-container .profile-quote").text


    doc = doc.css("div.vitals-container")
    counter = 1
    while counter < 8
      if doc.children[3].children[counter] == nil
        value = 'no'
        counter = 8
      elsif doc.children[3].children[counter].attributes["href"] == nil
        value = 'no'
        counter = 8
      else
        value = doc.children[3].children[counter].attributes["href"].value
      end


      case
      when value.include?('twitter')
        hash[:twitter] = value
      when value.include?('github')
        hash[:github] = value
      when value.include?('linkedin')
        hash[:linkedin] = value
      when value.include?('facebook')
      when value.include?('youtube')
      when value.include?('instagram')
      when value.include?(".com")
        hash[:blog] = value
      end
      counter = counter + 2
    end
    return hash

  end

end
