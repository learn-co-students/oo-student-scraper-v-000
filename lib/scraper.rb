require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open("#{index_url}")
    doc = Nokogiri::HTML(html)
    doc.css('div.student-card').each do |student|
      hash = {}
      hash[:name] = student.css('.student-name').text
      hash[:location] = student.css('.student-location').text
      link = student.at_css('a[href]')
      hash[:profile_url] = link['href']
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profiles = []
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)
    hash = {}
    student = doc.css('div.main-wrapper')
    #Pull out all social links into urls array
    links = student.css('.social-icon-container a[href]')
    urls = []
    links.each {|link| urls << link['href']}
    #Iterate through urls array to find any applicable to hash
    urls.each do |url|
      if url.include?("twitter")
        hash[:twitter] = url
      elsif url.include?("linkedin")
        hash[:linkedin] = url
      elsif url.include?("github")
        hash[:github] = url
      else !url.include?("twitter" || "linkedin" || "github")
        hash[:blog] = url
      end
    end
    #Add final keys to hash
    hash[:profile_quote] = student.css('.profile-quote').text
    hash[:bio] = student.css('.details-container p').text
    return hash
  end

end
