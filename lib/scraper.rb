require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(url)
    html = File.read(url)
    index = Nokogiri::HTML(html)
    students = {}
    array = []
    index.css('div.student-card').each {|student|
    students = {
    :name => student.css('.student-name').text,
    :location => student.css(".student-location").text,
    :profile_url => student.css('a').attribute('href').value
      }
      array << students
      }
    array
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
   links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    
   student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css("div.description-holder p").text

    student
    
   end
end