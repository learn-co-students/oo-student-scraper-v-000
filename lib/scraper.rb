require 'nokogiri'
require 'open-uri'
require 'pry'


require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    students = []

    html.css(".student-card").each do |student|
      students.push({
  			:name => student.css("h4").text,
  			:location => student.css("p").text,
 			  :profile_url => index_url + "/" + student.css("a").attribute("href").value
 		})
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}

    html = Nokogiri::HTML(open(profile_url))

    html.css("div.social-icon-container a").each do |urls|
      url = urls.attribute("href").value
      students[:linkedin] = url if urls.include?("linkedin")
      students[:twitter] = url if urls.include?("twitter")
      students[:github] = url if urls.include?("github")
      students[:blog] = url if urls.css("img").attribute("src").text.include?("rss")
      students[:profile_quote] = html.css(".profile-quote").text
      students[:bio] = html.css(".description-holder p").text
    end


     students

  end

end

