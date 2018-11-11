require 'pry'
require 'open-uri'
require 'nokogiri'

  class Scraper
    
      def self.scrape_index_page(index_url)
        html = open(index_url)
        roster_page = Nokogiri::HTML(html)
    
        students = []
        roster_page.css(".student-card").each do |student|
          students << {
            :name => student.css(".student-name").text,
            :location => student.css(".student-location").text,
            #return a link instead of text use the code below.
            :profile_url => student.css("a").attribute("href").value
          }
        end
        students
    end

    def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      profile_page = Nokogiri::HTML(html)
  
      student = {}
  
      profile_page.css(".social-icon-container a").each do |platform|
        link = platform.attribute("href").value
        src = platform.css("img").attribute("src").value
  
        if src.include?("twitter")
          student[:twitter] = link
        elsif src.include?("linkedin")
          student[:linkedin] = link
        elsif src.include?("github")
            student[:github] = link
        elsif src.include?("rss")
          student[:blog] = link
        end
      end
  
      student[:profile_quote] = profile_page.css(".vitals-text-container div.profile-quote").text
      student[:bio] = profile_page.css(".bio-content.content-holder div.description-holder p").text
      student
  end
end



