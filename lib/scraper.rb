require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def self.scrape_index_page(index_url)
    doc=Nokogiri::HTML(open(index_url))

    students = []
    
    doc.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc=Nokogiri::HTML(open(profile_url))
    
    student_profile = {}
  
    doc.css("div.social-icon-container a").each do |link_xml|
      case link_xml.attribute("href").value
      when /twitter/
        student_profile[:twitter] = link_xml.attribute("href").value
      when /github/
        student_profile[:github] = link_xml.attribute("href").value
      when /linkedin/
        student_profile[:linkedin] = link_xml.attribute("href").value
      else
        student_profile[:blog] = link_xml.attribute("href").value
      end
    end
    
    student_profile[:profile_quote] = doc.css("div.profile-quote").text
    student_profile[:bio] = doc.css("div.description-holder p").text 
    student_profile
  end
    
end

