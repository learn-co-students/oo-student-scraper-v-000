require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css(".student-card").each do |student|
      students << {name: student.css("a .card-text-container h4").text,
        location: student.css("a .card-text-container p").text,
         profile_url: student.css("a").attribute("href").value.insert(0, "./fixtures/student-site/")}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    information = { profile_quote: doc.css(".vitals-text-container div.profile-quote").text, bio: doc.css("div.details-container p").text}

    doc.css(".social-icon-container a").each do |link|
      social = link.attribute("href").value
      if social.include?("twitter")
        information[:twitter] = social
      elsif social.include?("linkedin")
        information[:linkedin] = social
      elsif social.include?("github")
        information[:github] = social
      else
        information[:blog] = social
      end
    end
    information
  end

end
