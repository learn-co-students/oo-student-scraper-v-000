
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |roster|
      #iterate thru the roster cards then each student to get the student: name location and url
      roster.css(".student-card").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_link = student.css('a')[0]['href']
          students << {name: name, location: location ,profile_url: profile_link}
    end
  end
  students
end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_student = {}

    profile_page.css(".social-icon-container").each do |container|
      container.css("a").each do |link|
        if link['href'].include?('twitter')
          scraped_student[:twitter] = link['href']
        elsif link['href'].include?('linkedin')
           scraped_student[:linkedin] = link['href']
         elsif link['href'].include?('github')
          scraped_student[:github] = link['href']
        else
          scraped_student[:blog] = link['href']
         end
       end
     end
      profile_page.css(".profile-quote").each do |quote|
           scraped_student[:profile_quote] = quote.text
         end
      profile_page.css(".bio-content").css(".content-holder").each do |bio|
           scraped_student[:bio] = bio.css(".description-holder").text.strip
      end
    scraped_student
   end




# class end
end
