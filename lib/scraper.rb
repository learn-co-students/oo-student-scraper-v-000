require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = {}
    array = []

    doc.css(".student-card").each do |student|
    array <<
      {
    		:name => student.css("h4.student-name").text,
    		:location => student.css("p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"
        #"http://127.0.0.1:4000/#{student.css("a").first["href"]}"
    	}

    end
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    doc.css(".social-icon-container").each do |icon|
      icon.css("a").each do |link|
        if link.attribute("href").value.include?("linkedin")
          hash[:linkedin]= link.attribute("href").value
        elsif link.attribute("href").value.include?("twitter")
          hash[:twitter]= link.attribute("href").value
        elsif link.attribute("href").value.include?("github")
          hash[:github] = link.attribute("href").value
        elsif
          hash[:blog] = link.attribute("href").value
        end
        hash[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
        hash[:bio] = doc.css(".details-container").css(".bio-block").css(".bio-content").css(".description-holder").css("p").text
      end
    end
    hash
  end

end


