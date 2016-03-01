require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_scrape = Nokogiri::HTML(open(index_url))

    student_index_array = []

    index_scrape.css("div.student-card").each do |student|
      array_element = {
        :name => student.css("h4.student-name").text,
        :location => student.css("a div.card-text-container p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"
      }
      student_index_array << array_element
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    profile_scrape = Nokogiri::HTML(open(profile_url))

    profile_hash = {}

    profile_scrape.css('div.social-icon-container a').each do |link|
      if link.attribute('href').value.to_s.include?('twitter')
        profile_hash.store(:twitter,link.attribute('href').value)
      elsif link.attribute('href').value.to_s.include?('linkedin')
        profile_hash.store(:linkedin,link.attribute('href').value)
      elsif link.attribute('href').value.to_s.include?('github')
        profile_hash.store(:github,link.attribute('href').value)
      elsif link.css('img.social-icon').attribute('src').value.to_s.include?('rss')
        profile_hash.store(:blog,link.attribute('href').value)
      end
    end
    profile_hash.store(:profile_quote,profile_scrape.css('div.profile-quote').text)
    profile_hash.store(:bio,profile_scrape.css('div.description-holder p').text)

    profile_hash
  end
end
