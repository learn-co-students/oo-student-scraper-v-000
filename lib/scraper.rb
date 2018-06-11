require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
       all = []

         doc.css(".student-card").each do |student_card|
           hash={
             name: student_card.css(".student-name").text,
             location: student_card.css(".student-location").text,
             profile_url: student_card.css("a").attribute("href").value
           }
            all << hash
         end
         all

       end

 def self.scrape_profile_page(profile_url)
  doc = Nokogiri::HTML(open(profile_url))
  profile_links=[]
  hash={}
  doc.css(".social-icon-container a").each {|link| profile_links<<link['href']}

  profile_links.each do |site|
     if site.include?"twitter"
         hash[:twitter]= site
     elsif site.include?"linkedin"
           hash[:linkedin]= site
      elsif site.include?"github"
           hash[:github]= site
      else
           hash[:blog]=site
        end
      end
      hash[:profile_quote]=doc.css(".vitals-text-container .profile-quote").text
      hash[:bio]= doc.css(".description-holder p").text
      hash

  end
end
