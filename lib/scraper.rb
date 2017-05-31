require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative './student.rb'

class Scraper

      index_url = 'file:///home/andrew/code/labs/oo-student-scraper-v-000/fixtures/student-site/index.html'
      profile_url = "file:///home/andrew/code/labs/oo-student-scraper-v-000/fixtures/student-site/*"


      def self.scrape_index_page(index_url)
          html = open(index_url)
          doc = Nokogiri::HTML(html)
            students = []
                doc.css('div .roster-cards-container').each do |profile|
                
                     profile.css(".student-card a").each do |card|
                        student_name = card.css('.student-name').text
                        student_location = card.css('.student-location').text
                        student_profile_url = "#{card.attr('href')}"
                      
                        students <<  {:name => student_name, :location => student_location, :profile_url => student_profile_url}
                      end
                 end
                    
          students 
      end


    def self.scrape_profile_page(profile_url)
          profiles = {}
          html = open(profile_url)
          profile_pages = Nokogiri::HTML(html)

             links = profile_pages.css('.social-icon-container').children.css('a').collect do |profile|
              profile.attribute('href').value
              end
        
              links.each do |link|
                
                if link.include?('twitter')
                  profiles[:twitter] = link
                elsif link.include?('github')
                  profiles[:github] = link
                elsif link.include?('facebook')
                  profiles[:facebook] = link
                elsif link.include?('linkedin')
                  profiles[:linkedin] = link
                else link.include?('.com')
                  profiles[:blog] = link

               end
               
               profiles[:profile_quote] = profile_pages.css('.profile-quote').text
               profiles[:bio] = profile_pages.css('.details-container p').text
               
              end

        
        profiles
        
      end
    

end