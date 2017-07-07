require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    scraper = Nokogiri::HTML(html)
    students_array = []
    student_hash = {}
    scraper.css(".student-card").each do |card|
      students_array.push({:name => card.css("div.card-text-container h4").text,
        :location => card.css("p").text,
        :profile_url => card.css('a').attr('href').value})

      end
      students_array
    end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    scraper = Nokogiri::HTML(html)
    student_hash = {}
    scraper.css(".social-icon-container a").each do |link|

      #binding.pry
      if link.attr("href").include?("twitter")
      student_hash[:twitter] = link.attr('href')
      elsif link.attr("href").include?("linkedin")
       student_hash[:linkedin] = link.attr('href')
      elsif link.attr("href").include?("github")
      student_hash[:github] = link.attr('href')
      else
          student_hash[:blog] = link.attr('href')
          #binding.pry
      end
    end # end of link iteration
      #binding.pry
      student_hash[:profile_quote] = scraper.css("div.profile-quote").text
      student_hash[:bio] = scraper.css("div.description-holder p").text
      #binding.pry
      student_hash
   end # end of method

end # end of class
