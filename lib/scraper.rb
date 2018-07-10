require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #index_url = "./fixtures/student-site/index.html"
    
    doc = Nokogiri::HTML(open(index_url))
    
    student_hash = []
    
    doc.css("div.roster-cards-container div.student-card").each do |post|
       name = post.css("h4").text
       location = post.css("p").text
       profile_url = post.css("a")[0]["href"]
       student_hash.push ({:name => name, :location => location, :profile_url => profile_url})
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    #profile_url = "./fixtures/student-site/students/joe-burgess.html" 
    twitter, linkedin, github, blog = nil
    
    doc = Nokogiri::HTML(open(profile_url))

    socialLinks = doc.css("div.social-icon-container a")
    
    socialLinks.each {|link|
      if link["href"].include?("twitter.com")
        twitter = link["href"]
      else 
        if link["href"].include?("linkedin.com")
          linkedin = link["href"]
        else 
          if link["href"].include?("github.com")
            github = link["href"]
          else 
            blog = link["href"]
          end
        end
      end
    }

    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.bio-block div.description-holder").text.strip

    #binding.pry


    scrapedProfile = {:twitter =>twitter, :linkedin =>linkedin, :github =>github, :blog =>blog, :profile_quote =>profile_quote, :bio =>bio}



  end

end


