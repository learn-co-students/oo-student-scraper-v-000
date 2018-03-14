require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    profile_page = Nokogiri::HTML(html)
    students = []

    #Iterate through the students, adding them to the hash
    profile_page.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
    end

    #return the students hash
    students
  end

  def self.scrape_profile_page(profile_url)

    linkedin_src = "../assets/img/linkedin-icon.png"
    facebook_src = "../assets/img/facebook-icon.png"
    twitter_src = "../assets/img/twitter-icon.png"
    github_src = "../assets/img/github-icon.png"
    youtube_src = "../assets/img/rss-icon.png"
    blog_src = "../assets/img/rss-icon.png"

    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = {}

    #Add the profile quote and the bio to the student hash of attributes
    student[:profile_quote] = profile_page.css("div.profile-quote").text
    student[:bio] = profile_page.css("div.description-holder>p").text

    #Iterate through the student again, grabbing any links they appear and adding them to the hash
    profile_page.css("div.social-icon-container a").each do |link|
      if link.css("img.social-icon").attribute("src").value == linkedin_src
        student[:linkedin] = link.attribute("href").value
      elsif link.css("img.social-icon").attribute("src").value == facebook_src
        student[:facebook] = link.attribute("href").value
      elsif link.css("img.social-icon").attribute("src").value == twitter_src
        student[:twitter] = link.attribute("href").value
      elsif link.css("img.social-icon").attribute("src").value == github_src
        student[:github] = link.attribute("href").value
      #elsif link.css("img.social-icon").attribute("src").value == youtube_src
        #student[:youtube] = link.attribute("href").value
      elsif link.css("img.social-icon").attribute("src").value == blog_src
        student[:blog] = link.attribute("href").value
      end
    end

    #return the students hash
    student
  end

end
