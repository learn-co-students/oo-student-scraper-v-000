require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

   def self.scrape_index_page(index_url)
    html = open(index_url) 
    list = Nokogiri::HTML(html)

    # Student Names
    names = list.css(".student-name")
    names_array = []
    names.each do |item|
      names_array << item.text
    end
    names_array

    # Locations 
    locations = list.css(".student-location")
    location_array = []
    locations.each do |item|
      location_array << item.text
    end
    location_array

    # HTML pages 
    webpages = list.css(".student-card a[href]")
    webpage_array = []
    webpages.select do |item|
      webpage_array << item['href']
    end
    webpage_array


    master_array = []
    hash = {}
    x = 0
    names_array.each do |name|
      master_array << {:name => name, :location => location_array[x], :profile_url => webpage_array[x]}
      x = x + 1
    end
    master_array
  end
  
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    students_twitter = []
    students_linkedin = []
    students_github = []
    students_youtube = []
    students_blog = []

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("twitter")
        students_twitter << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("linkedin")
        students_linkedin << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("github")
        students_github << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if !(link['href'].include?("github")) &&
         !(link['href'].include?("linkedin")) &&
         !(link['href'].include?("twitter"))
         students_blog = link['href']
      end
    end

    students_quote = doc.css(".profile-quote").text
    students_bio = doc.css(".description-holder p").text

    students_twitter
    students_linkedin
    students_github
    students_youtube
      if students_youtube = ""
        students_youtube = nil
      end
    students_blog

    output = {:twitter=>students_twitter[0],
               :linkedin=>students_linkedin[0],
               :github=>students_github[0],
               :profile_quote=>students_quote,
               :blog=>students_blog,
               :bio=> students_bio}
    output.delete_if {|key, value| value == [] || value == nil}

    output
  end
  
end 