require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))

    students = []
    
    doc.css(".student-card").each do |student|
      
      index = index_url.sub("index.html", "")
      students << {
        :name => student.css("a .card-text-container h4").text,
        :location => student.css("a .card-text-container p").text,
        :profile_url => index + student.css("a").attribute("href").value
      }
    end
     
    students
   

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))

    student = Hash.new

    # doc.css(".social-icon-container a").each do |profile|
      
     #binding.pry
      doc.css(".social-icon-container a").each do |container|
        if container.include?("twitter")
          twitter_url = container.attribute("href").value
          student[:twitter] = twitter_url
        elsif container.include?("linked")
          linkedin_url = container.attribute("href").value
          student[:linkedin] = linkedin_url
        elsif container.include?("github")
          github_url = container.attribute("href").value
          student[:github] = github_url
        else
          blog_url = container.attribute("href").value
          student[:blog] = blog_url
        end
          student
      end


    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
      
    student


  end
  scrape_profile_page("http://students.learn.co/students/steve-frost.html")

end
