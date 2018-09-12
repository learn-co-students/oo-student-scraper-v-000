require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    student_page = Nokogiri::HTML(html)
    scraped_students = []
    
    student_page.css(".student-card").each do |card|
      hash = {
        :name => card.css("h4").text,
        :location => card.css("p").text,
        :profile_url => card.css("a").first["href"]
      }
    scraped_students << hash
  end 
    scraped_students
    
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    page = Nokogiri::HTML(html)
    
    hash = Hash.new { |hash, key| hash[key] = 'none' }
    
    urls = page.css(".vitals-container").css('a')
    links = urls.map {|element| element["href"]}.compact
    links.each do |i|
      if i.include? "twitter"
        hash[:twitter] = i
        elsif i.include? "linked"
        hash[:linkedin] = i
        elsif i.include? "github"
        hash[:github] = i
      else 
        hash[:blog] = i
      end 
    end
    
    hash[:profile_quote] = page.css(".profile-quote").text
    hash[:bio] = page.css(".description-holder").first.css("p").text

  hash 
  end 
  end 
