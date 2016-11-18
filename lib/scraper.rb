require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    return_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css('a')[0]['href']}"
      }
      return_array << student_hash
    end
    return_array
  end

  def self.scrape_profile_page(profile_url)
    return_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css('.social-icon-container a').each do |icon|
      if icon.css('img')[0]['src'].include?('rss-icon')
        return_hash[:blog] = icon['href']
      elsif icon['href'].include?('github')
        return_hash[:github] = icon['href']
      elsif icon['href'].include?('twitter')
        return_hash[:twitter] = icon['href']
      elsif icon['href'].include?('linkedin')
        return_hash[:linkedin] = icon['href']
      end
    end
    return_hash[:bio] = doc.css('.description-holder > p').text
    return_hash[:profile_quote] = doc.css('.profile-quote').text
    return_hash
  end

end
