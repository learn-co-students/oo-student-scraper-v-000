require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_arr = []
# method is responsible for scraping the index page that lists all of the students
    doc = Nokogiri::HTML(open(index_url)).css(".student-card")
    # doc.search("h4").text names
    # .search("p").text locations
    # student.css('a')[0]['href']
    doc.each do |student|
      index_arr << {:name=> "#{student.search("h4").text}", :location=> "#{student.search("p").text}", :profile_url=> "#{student.css('a')[0]['href']}"}
    end
    index_arr
  end

  def self.scrape_profile_page(profile_url)
    page_hash = {}
    # method is responsible for scraping an individual student's profile page
    # case statements or if/elseif statements to handle the github,
    # linkden, facebook and youtube cases so that all that could be left were blog sites
    doc = Nokogiri::HTML(open(profile_url))
    page_hash[:profile_quote] = doc.css(".profile-quote").text
    page_hash[:bio] = doc.css("p").text

    doc.css('a').each do |x|
      if x['href'].include?("github")
        page_hash[:github] = x['href']
      elsif x['href'].include?("twitter")
        page_hash[:twitter] = x['href']
      elsif x['href'].include?("linkedin")
        page_hash[:linkedin] = x['href']
      elsif !x['href'].include?("youtube") && !x['href'].include?("../")
        page_hash[:blog] = x['href']
      end
    end
    # plan is to use each to go through links to see if they include string(if else block) then add like this page_hash[:github] = href
    page_hash

  end

end
