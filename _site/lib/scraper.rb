require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

   doc = Nokogiri::HTML(open(index_url))
   names_array = doc.css('div.card-text-container h4').collect {|el| el.text }
   location_array = doc.css('div.card-text-container p').collect {|el| el.text}
   profile_url_array = doc.css('div.student-card a').collect {|el| el['href']}

   students_array = []

   names_array.each_with_index do |name, index|
     students_array << Hash[name: name, location: location_array[index], profile_url: "http://159.203.117.55:4187/fixtures/student-site/"+profile_url_array[index]]
   end
   students_array
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    profile_quote = doc.css('div.profile-quote').text
    bio = doc.css('div.description-holder p').text

    social = doc.css('div.social-icon-container a').collect {|el| el['href'] }
    social.each do |link|
     if link.include?("twitter")
       twitter = link
     elsif link.include?("linkedin")
       linkedin = link
     elsif link.include?("github")
       github = link
     else
       blog = link
     end
    end
    student = Hash[twitter: twitter, linkedin: linkedin, blog: blog, github: github, profile_quote: profile_quote, bio: bio]
    student.reject!{|k,v| v == ""}
    student
   end
end
