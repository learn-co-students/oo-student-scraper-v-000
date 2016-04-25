require 'open-uri'
require 'pry'
require 'nokogiri'
#student:doc.css('.student-card')
#url:student.css("a").attribute("href").value
#student_name:student.css('.student-name').text
#student_location:student.css('.student-location').text

#s
#profile_quote:doc.css('.profile-quote').text

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css('.student-card').each do |student|
      student_name = student.css('.student-name').text
      student_info = {
        :name => student_name,
        :location => student.css('.student-location').text,  
        :profile_url => "#{index_url}#{student.css("a").attribute("href").value}"
      }
      
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    students = {}
    doc.css('.social-icon-container a').each do |site|
      sites = site.attribute("href").value

      if sites.include?('twitter')
        students[:twitter] = sites
      elsif sites.include?('linkedin')
        students[:linkedin] = sites
      elsif sites.include?('github')
        students[:github] = sites
      else
        students[:blog] = sites
      end

      students[:profile_quote] = doc.css('.profile-quote').text
      students[:bio] = doc.css('.description-holder p').text
      
    end
    students
  end
end


