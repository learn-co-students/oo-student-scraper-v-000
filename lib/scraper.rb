require 'open-uri'
require 'Nokogiri'
require 'pry'
class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
        
    index_page.css(".student-card").each do |student_card|
        student_name = student_card.css(".student-name").text
        student_location = student_card.css(".student-location").text
        student_profile_url = "http://127.0.0.1:4000/" + student_card.css("a").attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    
    links = []
    blog, twitter, github, linkedin = nil, nil, nil, nil
    social = profile_page.css(".social-icon-container > a")
    social.each do |s| 
      social_icon = s.css("img").attribute("src").value
      link = s.attribute("href").value
      if social_icon =~ /twitter/
        twitter = link
      elsif social_icon =~ /linkedin/
        linkedin = link
      elsif social_icon =~ /github/
        github = link
      elsif social_icon =~ /rss/
        blog = link
      end
    end
    
    student[:twitter] = twitter if twitter
    student[:blog] = blog if blog
    student [:github] = github if github
    student [:linkedin] = linkedin if linkedin
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".bio-content > .description-holder p").text 
    student
  end
end

scraper = Scraper.scrape_profile_page('http://127.0.0.1:4000/students/david-kim.html')