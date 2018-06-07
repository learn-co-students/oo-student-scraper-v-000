require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open("fixtures/student-site/index.html"))
    student_card = doc.css(".student-card")
    array = []
    student_card.each do |student|
      array << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
      }

      end
      array
    end


    def self.scrape_profile_page(profile_url)
   profile_hash = {}
   html = open(profile_url)
   doc = Nokogiri::HTML(html)
   student = doc.css("div .social-icon-container").children.css("a").map{|tag| tag.attribute("href").value}

   student.each do |link|
     if link.include?("twitter")
       profile_hash[:twitter] = link
     elsif link.include?("linkedin")
       profile_hash[:linkedin] = link
     elsif link.include?("github")
       profile_hash[:github] = link
     else
       profile_hash[:blog] = link

       #binding.pry
      end
    end
   profile_hash[:profile_quote] = doc.css(".profile-quote").text
   profile_hash[:bio] = doc.css(".description-holder p").text
   profile_hash
 end

end
