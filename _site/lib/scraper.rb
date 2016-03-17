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
 #binding.pry
  doc = Nokogiri::HTML(open(profile_url))
  #binding.pry
   student_social_links = doc.css(".social-icon-container").css("a").collect do |s|
      s.attribute("href").value
   end #["https://twitter.com/jmburges", "https://www.linkedin.com/in/jmburges", "https://github.com/jmburges", "http://joemburgess.com/"]

  #twitter: post.css(".social-icon-container").css('a').attribute("href").value
  student_social_hash =
      {
        :twitter => student_social_links[0],
        :linkedin => student_social_links[1],
        github: student_social_links[2],
        blog: student_social_links.last,
        profile_quote: doc.css(".profile-quote").text,
        bio: doc.css(".description-holder").css("p").text
      }
  end

end

