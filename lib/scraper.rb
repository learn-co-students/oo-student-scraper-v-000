require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    Nokogiri::HTML(open(index_url)).css(".student-card").collect {|card|

    {
    name: card.css("h4").text,
    #binding.pry
    #student_names = doc.css(".student-card").css("h4")
    location: card.css("p").text,

    profile_url: "http://students.learn.co/#{card.css("a").attribute("href").value}"
      }}
end




def self.scrape_profile_page(profile_url)

  social_link_hash={}
 #binding.pry
  doc = Nokogiri::HTML(open(profile_url))
  #doc = Nokogiri::HTML(open("http://students.learn.co/students/david-kim.html"))
  #binding.pry
   student_social_links = doc.css(".social-icon-container").css("a").collect {|s|
      s.attribute("href").value }
  #binding.pry
   #["https://twitter.com/jmburges", "https://www.linkedin.com/in/jmburges", "https://github.com/jmburges", "http://joemburgess.com/"]
#For another student my array is ["https://www.linkedin.com/in/david-kim-38221690", "https://github.com/davdkm"]
  #twitter: post.css(".social-icon-container").css('a').attribute("href").value
#social_link_hash={
  #:twitter => student_social_links.each{|links| links.include?("twitter")},
  #:linkedin => student_social_links.each{|links| links.include?("linkedin")},
 # :github => student_social_links.each{|links| links.include?("github")},
 # :blog => student_social_links.last,
 # :profile_quote => doc.css(".profile-quote").text,
 # :bio => doc.css(".description-holder").css("p").text
 # }

student_social_links.collect do |links|
    if links.include?("twitter")
      social_link_hash[:twitter] = links
      else social_link_hash[:twitter] = nil
    end
     if links.include?("linkedin")
        social_link_hash[:linkedin] = links
       else  social_link_hash[:linkedin] = nil
     end
       if links.include?("github")
      social_link_hash[:github] = links
         else social_link_hash[:github] = nil
       end
end
      social_link_hash[:blog] = student_social_links.last
      social_link_hash[:profile_quote] = doc.css(".profile-quote").text,
      social_link_hash[:bio] = doc.css(".description-holder").css("p").text

  social_link_hash
end
end
  #}
      #  bio: doc.css(".description-holder").css("p").text


  #student_social_hash =
    #  {
     #   :twitter => student_social_links[0],
      #  :linkedin => student_social_links[1],
      #  github: student_social_links[2],
      #  blog: student_social_links.last,
      #  profile_quote: doc.css(".profile-quote").text,
      #  bio: doc.css(".description-holder").css("p").text
     # }




