require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = "http://127.0.0.1:4000/"
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []
    doc.css(".student-card").each do |student_card|
      student_index_array <<
        {:name => student_card.css(".student-name").text,
          :location => student_card.css(".student-location").text,
          :profile_url => index_url+(student_card.css("a").attribute("href").value)
        }
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
   doc = Nokogiri::HTML(open(profile_url))
   student_details = {}
   doc.css('.social-icon-container a').each do |link|
    if link['href'].include?('twitter')
      student_details[:twitter] = link['href']
    elsif link['href'].include?('linkedin')
      student_details[:linkedin] = link['href']
    elsif link['href'].include?('github')
      student_details[:github] = link['href']
    else 
      student_details[:blog] = link['href']
    end
  end
  student_details[:profile_quote] = doc.css('.profile-quote').text.strip
  student_details[:bio] = doc.css('.description-holder p').text.strip
  student_details   
  end

end

