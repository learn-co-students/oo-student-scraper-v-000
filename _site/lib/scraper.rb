require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  #name, location, profile_url
  def self.scrape_index_page(index_url)
    html = open(index_url)
    students = Nokogiri::HTML(html)
    students.css(".student-card").collect do |s|
      student = {
        name: s.css(".student-name").text,
        location: s.css(".student-location").text,
        profile_url: "http://127.0.0.1:4000/" << s.css("a").attribute("href").value
      }
    end
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    social_list = ["twitter", "linkedin", "github"]
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    answer = {
      bio: page.css(".description-holder p").text,
      profile_quote: page.css(".profile-quote").text
    } 
    social = page.css(".social-icon-container a")
    social.each do |s|
      url = s.attribute("href").value
      name = url.match(/[.\/](\w+)[.]com/)[1]
      name = "blog" if !social_list.include?(name)
      answer[name.to_sym] = url
    end
    answer
  end

end

#puts Scraper.scrape_profile_page("http://127.0.0.1:4000/fixtures/student-site/students/joe-burgess.html")