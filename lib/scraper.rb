require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    scraped_students = []

    #iterating through the students
    student_site.css("div.student-card").each do |student|
      scraped_students << {
        :name => student.css("a div.card-text-container h4.student-name").text, :location => student.css("a div.card-text-container p.student-location").text, :profile_url => "http://students.learn.co/" + student.css("a").attribute("href").text 
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    student_site = Nokogiri::HTML(open(profile_url))
    student_links = {}
    
    student_site.css("div.main-wrapper a").each do |student|
      link = student.attributes['href'].value
        if /twitter/.match(link)
          student_links[:twitter] = link
        elsif /linked/.match(link)
          student_links[:linkedin] = link 
        elsif /github/.match(link) 
          student_links[:github] = link 
        elsif /#/.match(link)
          student_links[:blog] = link 
        end
    student_links[:profile_quote] = student.css("div.vitals-container div.vitals-text-container div.profile-quote").text
    student_links[:bio] = student.css("div.details-container div.bio-block div.description-holder p").text
    end
    student_links
  end

end

