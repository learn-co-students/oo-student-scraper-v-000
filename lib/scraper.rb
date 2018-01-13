require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html=open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
     students.collect do |info|
       {name: info.css(".student-name").text, location: info.css(".student-location").text, profile_url: info.children[1]["href"]}
    end
  
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url)
    doc = Nokogiri::HTML(html)
    student = doc.css(".profile")
    hash = {}
     array = student.collect do |info|
        info.css("a").each do |link|
          #binding.pry
         if link["href"].include? "twitter"
            hash[:twitter] = link["href"]
            elsif link["href"].include? "github"
            hash[:github] = link["href"]
            elsif link["href"].include? "linkedin"
            hash[:linkedin] = link["href"]
            elsif link["href"].include? ".com"
            hash[:blog] = link["href"]
          end
          
        end
    hash[:profile_quote] = info.css(".profile-quote").text
    hash[:bio] = info.css(".bio-block p").text
     end
     hash
     
  end

end

