require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    # To Do: ask? in what order should i return my student_hashs array

    student_hashs = []
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css('.student-card')
    student_cards.each do |student_card|
      student_hash = {}
      student_hash[:name] = student_card.css('.student-name').text
      student_hash[:location] = student_card.css('.student-location').text
      student_hash[:profile_url] = student_card.css('a').map {|link| link.attribute('href').to_s}
      # binding.pry
      student_hashs << student_hash
    end
    student_hashs.sort do |student_1, student_2|
      student_1[:name].split(' ').last <=> student_2[:name].split(' ').last
    end
  end

  def self.scrape_profile_page(profile_url)
    # data to get: name, location, twitter, linkedin, github, blog, profile_quote, bio, profile_url
  end

end
