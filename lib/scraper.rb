require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

#----------------------------------------------------------------
def self.scrape_index_page(index_url)
          
          #gets the whole html doc
          raw_doc = Nokogiri::HTML(open(index_url))
          
          #goes through each student card and puts into array
          student_card_array =[]
          raw_doc.css(".student-card").each{|student_card|
                                                          #shovel a hash into student card array for each student card in raw_doc
                                                          student_card_array << {
                                                                                :name => student_card.css(".student-name").text,
                                                                                :location => student_card.css(".student-location").text,
                                                                                :profile_url => student_card.css("a").attribute("href").value
                                                                                }
                                            } 

student_card_array
end


#----------------------------------------------------------------
def self.scrape_profile_page(profile_url)
        
        #gets an indiv students profile page into a nokogiri doc
        raw_doc = Nokogiri::HTML(open(profile_url))

        puts raw_doc.css(".bio-content .description-holder p").text
        puts raw_doc.css(".profile-quote").text
        puts raw_doc.css("div.social-icon-container a[href*=linkedin]").attribute("href").value
        

        



end




#-- end of Scraper class
end

