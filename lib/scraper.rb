require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    #Student name: doc.css("div.student-card").css("h4.student-name").text
    #Student location: doc.css("div.student-card").css("p.student-location").text
    #Student profile: doc.css("div.student-card a").attribute("href").value
    index_array = []

    doc.css("div.student-card").each do |student|
         hash = {}
	       hash[:name] = student.css("h4.student-name").text
	       hash[:location] = student.css("p.student-location").text
	       hash[:profile_url] = "./fixtures/student-site/" + student.css("a").attribute("href").value
         index_array << hash
    end
    index_array
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    # doc.css("div.social-icon-container a").attribute("href").value
    #   ==> contains one or more of (:twitter, :linkedin, :github, :blog)
    # doc.css("div.profile-quote").text ==> :profile_quote
    # doc.css("div.description-holder p").text ==> :bio
    profile_hash = {}

    hrefs = doc.css("div.social-icon-container a")
    if hrefs.each do |href|
        if href["href"].match(/twitter/)
            profile_hash[:twitter] = href["href"]
        elsif href["href"].match(/linkedin/)
            profile_hash[:linkedin] = href["href"]
        elsif href["href"].match(/github/)
            profile_hash[:github] = href["href"]
        else
            profile_hash[:blog] = href["href"]
        end
      end
    end
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text
    profile_hash[:bio] = doc.css("div.description-holder p").text
    profile_hash
  end

end
