require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("http://127.0.0.1:4000/fixtures/student-site/"))
      students = []
      doc.css(".student-card").each do |student|
        students << {:name => student.css("h4").text,:location => student.css("p").text,:profile_url => index_url + student.css("a").attribute("href").value}
      end
    students 
  end

  def self.scrape_profile_page(profile_url)
    url_name = profile_url.delete(".html").split("/").last
    new_url = url_name+".html"
    doc = Nokogiri::HTML(open("http://127.0.0.1:4000/fixtures/student-site/students/"+new_url))
    social_links = []
    doc.css(".social-icon-container").css("a").each{|x|social_links << x['href']}
students = {:twitter => social_links.detect{|x| x.include?("twitter")},:linkedin => social_links.detect{|x| x.include?("linkedin")},:github => social_links.detect{|x| x.include?("github")},:blog  => social_links.last,:profile_quote => doc.css(".vitals-text-container").css(".profile-quote").text,:bio => doc.css(".description-holder").css("p").text

}


  end

end

#class - "student-card" this is inside the "roster-cards-container" class. 
#a href for the link
#class - "card-text-container" for the text
#h4.text = name
#p.text = location. 
#doc.css(".student-card").first.css("h4").text

#doc.css(".student-card").css("h4").text - name
#doc.css(".student-card").css("p").text - location
#doc.css(".student-card").css("a").attribute("href").value - link
#make a variable for doc.css(".student-card").css

#linkedin - .css(".social-icon-container").css("a").attribute("href").value
#github - .css(".social-icon-container").css("social-icon").attribute("src").css("github").css("a").attribute("href").value
#twitterurl - 
#blog url- 
#profile quote - 
#bio - 


#** - make an array. then doc up to ("a").each {|x| array << x['href']} - This puts all the links into an array.
#array.detect{|x| x.include?("linkedin")} - this gets the linkedin one. 