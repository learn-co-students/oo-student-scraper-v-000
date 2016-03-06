require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :linkedin, :github, :blog, :bio

  def self.scrape_index_page(index_url)
    result = []
    html = Nokogiri::HTML(open(index_url))

    html.css("div.roster-cards-container").each do |element|
      element.css("div.student-card").each_with_index {|element,index| result[index] = {:name => element.css("h4.student-name").text, :location => element.css("p.student-location").text, :profile_url => "http://127.0.0.1:4000/students/"+element.css("h4.student-name").text.split(" ").join("-").downcase!+".html" }}
    end
    result
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    student = {:bio => html.css("div.description-holder p").text, :profile_quote => html.css("div.profile-quote").text }

    html.css("div.social-icon-container a").each do |element|
      case true
        when element.attribute("href").value.include?("twitter")
          student[:twitter] = element.attribute("href").value
        when element.attribute("href").value.include?("linkedin")
          student[:linkedin] = element.attribute("href").value
        when element.attribute("href").value.include?("github")
          student[:github] = element.attribute("href").value
        else
          student[:blog] = element.attribute("href").value
      end
    end
    student
  end

end

