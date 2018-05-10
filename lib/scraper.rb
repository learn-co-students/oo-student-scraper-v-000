require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []
    page.css(".student-card").each do |student_card|
    #binding.pry
      student = {
        :name => student_card.css("h4").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => student_card.css("a").attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    social_icon_container = page.css(".social-icon-container")
      social_icon_container.each do |social_link|
        social_links = {
          :twitter => social_link.css("a").map{ |a| if a['href'].match("/twitter/")
          }
        
    # page.css(".vitals-container").each do |item|
    #   item.css(".social-icon-container") do |social_link|
        
      
      
    #   social_links = {
    #     :twitter =>
    #     :linkedin =>
    #     :github =>
    #     :blog =>
    #     :profile_quote =>
    #     :bio =>
    
  end

end

