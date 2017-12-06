require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
#is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students_index = Nokogiri::HTML(html)
    #binding.pry
    students = []
      students_index.css("div.student-card").each do |student_card|
        #name = student_card.css("h4.student-name").text #NOT a hash of hashes like kickstarter, just an array
        #binding.pry
        students << {
          :name => student_card.css("h4.student-name").text,
          :location => student_card.css("p.student-location").text,
          #:profile_url => "fixtures/student-site/#{student_card.css("a").attribute("href").text}" works for all but 3 for some reason, per zoom save the path fix for the usage end
          :profile_url => student_card.css("a").attribute("href").text
        }
        #binding.pry
      end
    students
    #binding.pry
  end #self.scrape_index_page


#is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
#can handle profile pages without all of the social links
  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_scrape = Nokogiri::HTML(html)
    output = {}
    output[:profile_quote] = student_scrape.css("div.profile-quote").text
    output[:bio] = student_scrape.css("div.description-holder p").text
    social_links = student_scrape.css("div.social-icon-container") #only gives first link with a href selectors, ugh.  No .text until yielding the saved values.
    #last_link = social_links.css("a:last-child")
    #output[:blog] = last_link.attribute("href").value #I give up on this.
    social_links = social_links.css("a")
    social_links = social_links.map {|link| link.attribute("href")} #piss poor but passes, why does attribute fix on the first one whereas everything else collects?
    #binding.pry
      social_links.map do |link|
        #binding.pry
        if link.value.include?("twitter")
          output[:twitter] = link.value
        elsif link.value.include?("linkedin")
          output[:linkedin] = link.value
        elsif link.value.include?("github")
          output[:github] = link.value
        #binding.pry
        else
          output[:blog] = link.value #want to use last child but this stuff is unreadable (can't search, everyone's last link is a different host. could delete elements as used?
        end
        #binding.pry
      end #end loop

        #binding.pry
    #binding.pry
    output
  end #self.scrape_profile_page
end #SCRAPER CLASS
