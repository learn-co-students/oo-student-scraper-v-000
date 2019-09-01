require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    return_array = []
    page = Nokogiri::HTML(open(index_url))

    page.css(".student-card").each do | el |
      student_hash = {}
      student_hash[:name] = el.css(".student-name").text
      student_hash[:location] = el.css(".student-location").text
      student_hash[:profile_url] = el.css("a")[0]["href"]
      return_array << student_hash
    end
    return_array
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student_hash = {}

    student_hash[:bio] = page.css("p").text
    student_hash[:blog] = page.css( ).text
    student_hash[:profile_quote] = page.css(".profile-quote").text
    page.css("div .social-icon-container a").each do | el |
      if el['href'].include?("twitter")
        student_hash[:twitter] = el['href']
      # elsif el['href'].include?("facebook")
      #   student_hash[:facebook] = el['href']
      elsif el['href'].include?("github")
        student_hash[:github] = el['href']
      elsif el['href'].include?("linkedin")
        student_hash[:linkedin] = el['href']
      else
        student_hash[:blog] = el['href']
      end
    end

    if student_hash[:blog] == ""
      student_hash.delete(:blog)
    end

    student_hash
  end

end
