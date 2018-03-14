require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |person|
      students << {:name => person.css("h4").text,
                   :location => person.css("p").text,
                   :profile_url => person.css("a").attribute("href").value
                 }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    links = {}

    links[:profile_quote] = doc.css(".vitals-text-container").first.css("div").text
    links[:bio] = doc.css(".description-holder").first.css("p").text

    doc.css(".social-icon-container a").each do |site|
      if site.attribute("href").value.include?("twitter")
          links[:twitter] = site.attribute("href").value
        elsif site.attribute("href").value.include?("linkedin")
          links[:linkedin] = site.attribute("href").value
        elsif site.attribute("href").value.include?("github")
          links[:github] = site.attribute("href").value
        else
          links[:blog] = site.attribute("href").value
      end
    end
    links
  end

end



    # binding.pry

    # profile_page = {}

    # profile_page[:linkedin] =
    # profile_page[:github] =
    # profile_page[:blog] =
    # profile_page[:profile_quote] =
    # profile_page[:bio] =

#binding.pry

#student names: doc.css(".student-card").first.css("h4").text
#student locations: doc.css(".student-card").first.css("p").text
#student profile URL: doc.css(".student-card").first.css("a").attribute("href").value
#profile bio: doc.css(".description-holder").first.css("p").text
#profile quote: doc.css(".vitals-text-container").first.css("div").text
