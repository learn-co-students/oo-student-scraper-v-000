require 'open-uri'
require 'pry'

class Scraper
   def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url)).css('div.roster-cards-container div.student-card')
      students = []
      doc.each do |post|
         student = {}
         student[:name] = post.css('.student-name').text
         student[:location] = post.css('.student-location').text
         student[:profile_url] = post.css('a').attribute('href').value
         students.push(student)
      end
      students
   end

   def self.scrape_profile_page(profile_url)
      student = {}
      doc = Nokogiri::HTML(open(profile_url))

      doc.css('div.social-icon-container a').each do |url|
         if url['href'].include? 'twitter'
            student[:twitter] = url['href']
         elsif url['href'].include?'github'
            student[:github] = url['href']
         elsif url['href'].include?'linkedin'
            student[:linkedin] = url['href']
         else
            student[:blog] = url['href']
         end
      end

      student[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
      student[:bio] = doc.css('div.description-holder p').text
      student
   end
end
