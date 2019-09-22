require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learnco = Nokogiri::HTML(html)
    array = []
    learnco.css("div.student-card").each do |student|
      array << {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    learnco = Nokogiri::HTML(html)
    student = {}
    links = []
    twitter, linkedin, github, blog = nil
    learnco.css("div.social-icon-container a").each do |link|
      links << link.attribute("href").value
    end
    links.each do |link|
      if link.include?("twitter")
        twitter = link
      elsif link.include?("linkedin")
        linkedin = link
      elsif link.include?("github")
        github = link
      else
        blog = link
      end
    end

    student = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => learnco.css("div.vitals-text-container div").text,
      :bio => learnco.css("div.description-holder p").text
    }
    student.delete_if {|key, value| value==nil}
    #binding.pry

  end

end
