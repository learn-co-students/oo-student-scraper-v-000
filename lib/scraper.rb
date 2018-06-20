require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    kick = Nokogiri::HTML(html)
    students = []
    kick.css("div.student-card").each do |ele|
      student = {:location => ele.css("p.student-location").text,
        :name => ele.css("h4.student-name").text,
        :profile_url =>ele.css("a")[0]["href"]
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    kick = Nokogiri::HTML(html)

    student = {:bio =>kick.css("div.bio-content.content-holder").css("div.description-holder").css("p").text ,
#      :blog =>kick.css("div.social-icon-container").css("a")[3]["href"],
#      :github =>kick.css("div.social-icon-container").css("a")[2]["href"],
#      :linkedin =>kick.css("div.social-icon-container").css("a")[1]["href"],
      :profile_quote => kick.css("div.profile-quote").text}
#      :twitter => kick.css("div.social-icon-container").css("a")[0]["href"] }
  kick.css("div.social-icon-container").css("a").each do
    |ele| if ele["href"].include? "github"
        student[:github]=ele['href']
    elsif ele["href"].include? "linkedin"
      student[:linkedin]=ele['href']
    elsif ele["href"].include? "twitter"
      student[:twitter]=ele["href"]
    else
      student[:blog]=ele["href"]
    end
  end

    student
  end

end
