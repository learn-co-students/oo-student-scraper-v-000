require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []

    roster =  doc.css(".card-text-container")
    names = roster.collect {|name| name.css("h4").text}
    locations = roster.collect {|location| location.css("p").text}

    links = doc.css('.student-card a')

    urls = links.collect {|url| url['href']}
    array = [[names], [locations], [urls]]

    i = 0
    while i < 110
      hash = {:name=> names[i], :location=> locations[i], :profile_url=> urls[i]}
      students << hash
      i = 1 + i
    end
students
  end

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    twitter = []
    linkedin = []
    github = []
    youtube = []
    blog = []


    doc.css(".social-icon-container a").map do |link|
      if link['href'].include?("twitter")
        twitter = link['href']
      end
    end

    doc.css(".social-icon-container a").map do |link|
      if link['href'].include?("linkedin")
        linkedin = link['href']
      end
    end

    doc.css(".social-icon-container a").map do |link|
      if link['href'].include?("github")
        github = link['href']
      end
    end

    doc.css(".social-icon-container a").map do |link|
      if !(link['href'].include?("github")) &&
        !(link['href'].include?("linkedin")) &&
        !(link['href'].include?("twitter"))
        blog = link['href']
      end
    end


    quote = doc.css(".profile-quote").text
    bio = doc.css(".description-holder p").text


    profile = {twitter: twitter, :linkedin=> linkedin, :github=> github,:blog=> blog, :profile_quote=> quote, :bio=> bio}
    profile.delete_if {|key, value| value == [] || value == nil}
    profile

  end

end
