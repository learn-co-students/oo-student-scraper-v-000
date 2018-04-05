require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

  data = Nokogiri::HTML(open("./fixtures/student-site/index.html"))

  data.css("a").collect do |student|

      {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => student.attribute("href").text
      }
    end
  end

  def self.scrape_profile_page(profile_url)

  shash= {}

  data = Nokogiri::HTML(open(profile_url))

  arr = data.css("a").collect { |student| student.attribute("href").text}

  news = arr.slice(1..-1)

  news.each do |social|
    if social.include?("twitter")
      shash[:twitter] = social
    elsif social.include?("linkedin")
      shash[:linkedin] = social
    elsif social.include?("github")
      shash[:github] = social
    else
      shash[:blog] = social
    end

    end
    shash[:profile_quote] = data.css(".profile-quote").text
    shash[:bio] = data.css("div.bio-content.content-holder div.description-holder p").text

    shash
  end

end
