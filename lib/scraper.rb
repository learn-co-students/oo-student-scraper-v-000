require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_hash = []
    index_page.css(".roster-cards-container").each do |card|
      card.css("a").each do |info|
        student_name = info.css(".student-name").text
        student_location = info.css(".student-location").text
        student_url = "#{info.attr('href')}"

        student_hash << {:name => student_name, :location => student_location, :profile_url => student_url}
      end
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
     page = Nokogiri::HTML(open(profile_url))
     student = {}
     container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
     container.each do |link|
       if link.include?("twitter")
         student[:twitter] = link
       elsif link.include?("linkedin")
         student[:linkedin] = link
       elsif link.include?("github")
         student[:github] = link
       elsif link.include?(".com")
         student[:blog] = link
       end
     end
     student[:profile_quote] = page.css(".profile-quote").text
     student[:bio] = page.css("div.description-holder p").text
     student
    end

end

