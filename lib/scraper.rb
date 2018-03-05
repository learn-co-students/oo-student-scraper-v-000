require 'open-uri'
require 'nokogiri'
require 'pry'



class Scraper



  #name: doc.css(".student-name").first.text


  def self.scrape_index_page(index_url)
    html = open("#{index_url}")
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".student-card").each do |student|
      students << {name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.css("a").attribute('href').value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)

    link_array = doc.css(".social-icon-container a").collect {|link| link.attribute('href').value}

    hash = Hash.new
    link_array.each do |link|
      if link.include?("https:")
        website = link.scan(/\w+(?=.com)/)
        hash[website[0].to_sym] = link
      else
        hash[:blog] = link
      end
    end

         hash[:profile_quote] = doc.css(".profile-quote").text
         hash[:bio] = doc.css(".description-holder p").text
        hash

  end

end
