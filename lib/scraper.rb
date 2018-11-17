require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  attr_accessor :students

  def self.scrape_index_page(index_url)
    html=open(index_url)
    list=Nokogiri::HTML(html)
    names=list.css(".student-card")
    student_names=[]
    names.each do |student_info|
      student_names<< {
        :name=>student_info.css("h4.student-name").text,
        :location=>student_info.css("p.student-location").text,
        :profile_url=>student_info.css("a").attribute("href").value,
      }
    end
    student_names
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url)
    list=Nokogiri::HTML(html)
    student_attributes={}
    list.css("div.social-icon-container a").each do |info|
      case info.attribute("href").value
        when /twitter/
          student_attributes[:twitter]=info.attribute("href").value
        when /linkedin/
          student_attributes[:linkedin]=info.attribute("href").value
        when /github/
          student_attributes[:github]=info.attribute("href").value
        else
          student_attributes[:blog]=info.attribute("href").value
      end
    end
    student_attributes[:profile_quote]=list.css("div.profile-quote").text
    student_attributes[:bio]=list.css("div.bio-content div.description-holder").text.strip
    student_attributes
  end

end
