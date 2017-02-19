require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)

    students = []
  
    roster.css("div.student-card").each do |student|
      student_name = student.css("h4.student-name").text
      students << {
        name: student_name,
        location: student.css("div.card-text-container p.student-location").text,
        profile_url: "./fixtures/student-site/"+"#{student.css("a").attribute("href").value}"
        }
    end# of do |student|
    students 
  end# of self.scrape_index_page


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    links = {}
    socials = profile.css("div.social-icon-container a")

      socials.each do |link|
        url = link.attribute("href").value 
         if url.match(/twitter/)
          links[:twitter] = url 
         elsif url.match(/linkedin/)
          links[:linkedin] = url 
         elsif url.match(/github/)
          links[:github] = url 
         elsif !url.match(/facebook/)
          links[:blog] = url 
        end# of if statement 

        #binding.pry 
      end# of do
      links[:profile_quote] = profile.css("div.profile-quote").text 
      links[:bio] = profile.css("div.description-holder p").text 
      links 
  end

end

