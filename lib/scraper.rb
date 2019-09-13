require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = {}
    roster = []

    doc.css(".roster-cards-container .student-card").each do |student|
      students = {
        :name => student.css("a h4.student-name").text,
        :location => student.css("a p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      roster << students
    end

    roster
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}
    link_array = []
    social_media_array = []

    doc.css("div.vitals-container div.social-icon-container a").each do |container|
      link = container.attribute("href").value
      link_array << link
      if link.include? "twitter"
        student[:twitter] = link
      elsif link.include? "linkedin"
        student[:linkedin] = link
      elsif link.include? "github"
        student[:github] = link
      elsif link.include? "facebook"
        student[:facebook] = link
      elsif link.include? "youtube"
        student[:youtube] = link
      else
        student[:blog] = link
      end
    end

    student[:profile_quote] = doc.css("div.vitals-container div.vitals-text-container div.profile-quote").text
    student[:bio] = doc.css("div.details-container div.bio-content div.description-holder p").text

    student
  end

end
