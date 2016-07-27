require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :students

  def self.scrape_index_page(index_url)
    info = Nokogiri::HTML(open(index_url))
    @students = []
    info.css("div.student-card a").each do |student|
      student_hash = {}
      name = student.css(".student-name").text
        student_hash[:name] = name
      location = student.css(".student-location").text
        student_hash[:location] = location
      url = "./fixtures/student-site/#{student.attr('href')}"
        student_hash[:profile_url] = url
      @students << student_hash
    end
    @students
  end
    #    info.css(".student-name").each do |student| 
#      index[:name] = student.text
#      end

#    info.css(".student-location").each do |location| 
#      index[:location] = location.text
#      end
    

    # info.css('div.student-card a').each {|url| index[:profile_url] = url['href']}
    
    

#   info.css(".card-text-container").first.css("student-name").text

#   info.css(".card-text-container").first.css(".student-location").text
#    
#   info.css('div.student-card a').each {|url| puts url['href']}
#
#   names = info.css(".student-name").each {|name| puts name.text}
#    locations = info.css(".student-location").each {|location| puts location.text}
#
#

  def self.scrape_profile_page(profile_url)
    student_info = Nokogiri::HTML(open(profile_url))
    student_summary = {}
    social = student_info.css(".social-icon-container a").map {|section| section.attr("href")}
    social.each do |url|
      if url.include?("twitter")
        student_summary[:twitter] = url
      elsif url.include?("linkedin")
        student_summary[:linkedin] = url
      elsif url.include?("github")
        student_summary[:github] = url
      else
        student_summary[:blog] = url
      end
    end
    profile_quote = student_info.css(".profile-quote").text
      student_summary[:profile_quote] = profile_quote
    bio = student_info.css(".description-holder").first.text.gsub("              ", "").gsub("\n", "").gsub("            ", "")
      student_summary[:bio] = bio
    return student_summary
  end


end

