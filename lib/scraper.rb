require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    formatted = Nokogiri::HTML(html)
    final = []
    students = formatted.css(".student-card")
    students.each do |student|
      hash = {}
      hash[:name] = student.css("h4.student-name").text
      hash[:location] = student.css("p.student-location").text
      hash[:profile_url] = "./fixtures/student-site/" + student.css("a").attribute("href").value
      final << hash
  end
  final
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    formatted = Nokogiri::HTML(html)
    hash = {}
    links = formatted.css(".social-icon-container").children.css("a").collect {|link| link.attribute("href").value}

    links.each do |link|
      if link.include?("twitter")
        hash[:twitter] = link
      elsif link.include?("linkedin")
        hash[:linkedin] = link
      elsif link.include?("github")
        hash[:github] = link
      else
        hash[:blog] = link
      end
    end

    hash[:profile_quote] = formatted.css(".profile-quote").text
    hash[:bio] = formatted.css("div.description-holder p").text
    hash
  end

end
