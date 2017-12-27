require 'open-uri'
require 'pry'

class Scraper
  
  ##url = student.css('a')[0]['href']
  ##name = student.css("h4").text
  ##location = student.css("p").text

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    doc.css("div .roster-cards-container .student-card").map do |student|
      {:name => student.css("h4").text, :location => student.css("p").text, :profile_url => student.css('a')[0]['href']}
    end
    
  end
  
  ##twitter= doc.css("a")[1]["href"]
  ##linkedin= doc.css("a")[2]["href"]
  ##github= doc.css("a")[3]["href"]
  ##blog= doc.css("a")[4]["href"]
  ##profile_quote= doc.css("div.profile-quote").text
  ##bio= doc.css("div.description-holder p").text
  
  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    doc = Nokogiri::HTML(open(profile_url))

     ##creates the key value pair from the HTML code

     doc.css("div.social-icon-container a").each do |i|

         #finds the icon name and uses it to create the key value pair dynamically

         b = i.css("img").attribute("src").text ##"../assets/img/twitter-icon.png"
         if b.include? ("-icon.png")
          b = b.split(/.*\/|-icon/) ##["", "twitter", ".png"]
          b[1] == "rss" ? scraped_student[:blog] = i.attribute("href").text : scraped_student[b[1].to_sym] = i.attribute("href").text
        end
         
    end
    
    scraped_student[:profile_quote] = doc.css("div.profile-quote").text
    scraped_student[:bio] = doc.css("div.description-holder p").text
    
    scraped_student
  end

end

