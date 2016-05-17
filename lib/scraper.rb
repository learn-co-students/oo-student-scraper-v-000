require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    roster = Nokogiri::HTML(open(index_url))
    #binding.pry
    students = []

    roster.css(".student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => index_url + student.css("a").attribute("href").text
      }

    end
    students
 
end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student_info = {:profile_quote => profile.css("div.profile-quote").text,
                    :bio => profile.css("div.description-holder p").text}

    profile.css(".social-icon-container a").each do |link|
      icon = link.attribute("href").value
      if icon.include?("twitter")
        student_info[:twitter] = icon
      elsif icon.include?("linkedin")
          student_info[:linkedin] = icon 
      elsif icon.include?("github")
          student_info[:github] = icon 
      else 
          student_info[:blog] = icon 
      end
    end
  student_info
end
end
