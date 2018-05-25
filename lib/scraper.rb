require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_profiles = doc.css("div.student-card")
    names = doc.css("div.card-text-container h4.student-name")
    locations = doc.css("div.card-text-container p.student-location")
    urls = doc.css("div.student-card a")
    student_profiles.each_with_index do |student, index|
      name = names[index].text
      location = locations[index].text
      url = urls[index].attributes['href'].value
      student_index << {:name=>name, :profile_url=>url, :location=>location}
    end
    student_index
  end
  
  def self.get_link(linkObject)
    link = linkObject.attributes['href'].value
    link
  end

  def self.scrape_profile_page(profile_url)
    twitter, linkedin, github, blog = ""
    student_profile = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_media = doc.css("div.social-icon-container a")
    social_media.each do |linkObject|
      linkText = self.get_link(linkObject)
      if linkText.include?("twitter")
        student_profile[:twitter] = linkText
      elsif linkText.include?("linkedin")
        student_profile[:linkedin] = linkText
      elsif linkText.include?("github")
        student_profile[:github] = linkText
      else
        student_profile[:blog] = linkText
      end
    end
    bio = doc.css("div.description-holder p")
    student_profile[:bio] = bio.text if bio != nil
    quote = doc.css("div.profile-quote")
    student_profile[:profile_quote] = quote.text if quote != nil
    student_profile
  end

end

