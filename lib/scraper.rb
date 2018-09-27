require 'open-uri'
require 'pry'


class Scraper
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        name = student.css(".card-text-container h4").text
        location = student.css("p.student-location").text
        profile_url = student.css("a").attr("href").text
        
        scraped_students << {:name => name, :location => location, :profile_url => profile_url}
      end
    end
   scraped_students 
  end
  
  

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    scraped_students = {}
    social_link = profile.css(".social-icon-container").children.css("a").map  {|link| link.attribute("href").value}
       social_link.each do |link_2|
       if link_2.include?("twitter")
         scraped_students[:twitter] = link_2
       elsif link_2.include?("linkedin")
         scraped_students[:linkedin] = link_2
       elsif link_2.include?("github")
         scraped_students[:github] = link_2
       elsif link_2.include?("youtube")
         scraped_students[:youtube] = link_2
       else
         scraped_students[:blog] = link_2
       end 
    end
  
         
         scraped_students[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
         if profile.css("div.bio-content.content-holder div.description-holder p").text
           scraped_students[:profile_quote] = profile.css(".profile-quote").text
         if profile.css(".profile-quote").text
  
   scraped_students
end
end
end
end


