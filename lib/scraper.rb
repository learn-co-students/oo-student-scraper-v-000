require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    studentsite =  Nokogiri::HTML(html)
    scraped_students = []
    studentsite.css(".student-card").each do | card |
      scraped_students << {:name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
       :profile_url => card.css("a").attribute("href").value}
      end
    scraped_students
    end
    #whole page
    #collection of cards = studentsite.css(".student-card")
    #:name = studentsite.css(".student-name").text
    #:location = studentsite.css(".student-location").text
    #:profile_url = studentsite.css(".student-card a").attribute("href").value


  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profilepage =  Nokogiri::HTML(html)
    scraped_student = {}
    links = profilepage.css(".social-icon-container").xpath("a/@href").map {|blurb| blurb.value}
    links.each do |link|
        if link.include?("twitter")
           scraped_student[:twitter] = link
        elsif link.include?("linkedin")
          scraped_student[:linkedin] = link
        elsif link.include?("github")
          scraped_student[:github] = link
        else scraped_student[:blog] = link
      end
    end
    scraped_student[:profile_quote] = profilepage.css(".profile-quote").text#.gsub('"','')
    scraped_student[:bio]= profilepage.css(".description-holder p").text
    scraped_student
  end

  #:twitter,
  #:linkedin,
  #:github,
  #:blog,
  #:profile_quote = profilepage.css(".profile-quote").text.gsub('"','')
  #:bio = profilepage.css(".description-holder p").text

end
