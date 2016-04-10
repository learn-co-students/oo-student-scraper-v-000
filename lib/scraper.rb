require 'open-uri'
require 'pry'

class Scraper

HOST = "http://127.0.0.1:4000/"

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(HOST))
    page.css(".student-card").map do |x|
      {
	:name => x.css(".student-name").text,
        :location => x.css(".student-location").text,
        :profile_url => HOST + x.css("a")[0]['href']
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    social = page.css(".social-icon-container a").map{|x| x['href']}
    social.each do |x|
      if x.include?("linkedin")
        student[:linkedin] = x
      elsif x.include?("github")
        student[:github] = x
      elsif x.include?("twitter")
        student[:twitter] = x
      else
        student[:blog] = x
      end
    end
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content").css(".description-holder p").text
    student
  end

end

