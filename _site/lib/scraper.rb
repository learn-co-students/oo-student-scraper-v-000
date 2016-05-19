require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
      students = []
      doc.css(".student-card").each do |student|
        students << {:name => student.css("h4").text,:location => student.css("p").text,:profile_url => "http://127.0.0.1:4000/"+ student.css("a").attribute("href").value}
      end
    students 
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    social_links = []
    doc.css(".social-icon-container").css("a").each{|x|social_links << x['href']}

    students = {}
    
      if social_links.select{|x| x[/twitter/]}.join != ""
        students[:twitter] = social_links.select{|x| x[/twitter/]}.join("")
      end

      if social_links.select{|x| x[/github/]}.join != ""
        students[:github] = social_links.select{|x| x[/github/]}.join("")
      end

      if social_links.select{|x| x[/linkedin/]}.join != ""  
        students[:linkedin] = social_links.select{|x| x[/linkedin/]}.join("")
      end

      if social_links.select{|x| !x[/twitter/] && !x[/github/] && !x[/linkedin/]}.join != ""
        students[:blog] = social_links.select{|x| !x[/twitter/] && !x[/github/] && !x[/linkedin/]}.join("")
      end

    students[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
    students[:bio] = doc.css(".description-holder").css("p").text
  
   students 
  end

end





