#http://ruby.bastardsbook.com/chapters/html-parsing/
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css(".student-card a").each do |student|
      #binding.pry
      url = student.attr('href') #same as --> student.attributes["href"].value
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      students << { :name => name, :location => location, :profile_url => url }
    end
      students
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = {}
    #binding.pry
    links = profile_page.css(".social-icon-container a").map { |icon| icon.attr("href") }
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    #binding.pry
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css(".description-holder p").text if profile_page.css(".description-holder p")
    student
  end

end
