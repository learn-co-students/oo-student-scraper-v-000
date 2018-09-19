require 'open-uri'
require 'pry'

class Scraper

  def self.get_page(url)
    doc = Nokogiri::HTML(open(url))
    #doc = File.open(url)
  end

  def self.scrape_index_page(index_url)
    doc = get_page(index_url)
    people = []
    doc.css("div.roster-cards-container div.student-card").each do |person|
      person_hash = {
        :name => person.css("a h4").text,
        :location => person.css("a p").text,
        :profile_url => person.css("a").attribute("href").text
      }
      people << person_hash
    end
    people
  end

  def self.scrape_profile_page(profile_url)
    doc = get_page(profile_url)
    student = {
      :profile_quote => doc.css("div.vitals-text-container div.profile-quote").text,
      :bio => doc.css(
        "div.details-container p").text
    }
    social_media = doc.css("div.vitals-container div.social-icon-container")
    social_media.css("a").each do |website|
      if website.attribute("href").text.include?("twitter")
        student[:twitter] = website.attribute("href").text
      elsif website.attribute("href").text.include?("git")
        student[:github] = website.attribute("href").text
      elsif website.attribute("href").text.include?("linkedin")
        student[:linkedin] = website.attribute("href").text
      else
        student[:blog] = website.attribute("href").text
      end
    end
    student
  end

end
