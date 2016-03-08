require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_array = []
    doc.css(".student-card").each do |student|
      name = student.css("a .card-text-container h4").text
      location = student.css("a .card-text-container p").text
      profile_url = student.css("a").attribute("href").value
      hash = {name: name, location: location, profile_url: profile_url}
      student_array << hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    twitter = nil
    linkedin = nil
    github = nil
    facebook = nil
    blog = nil
    links = doc.css(".social-icon-container a")
    links.each do|link|
      if link.attribute("href").value.match(/twitter/)
        twitter = link.attribute("href").value
      elsif link.attribute("href").value.match(/linkedin/)
        linkedin = link.attribute("href").value
      elsif link.attribute("href").value.match(/github/)
        github = link.attribute("href").value
      elsif link.attribute("href").value.match(/facebook/)
        facebook = link.attribute("href").value
      else
        blog = link.attribute("href").value
      end
    end
      profile_quote = doc.css(".profile-quote").text
      bio = doc.css(".description-holder p").text
      hash = {twitter: twitter, linkedin: linkedin, github: github, facebook: facebook, blog: blog, profile_quote: profile_quote, bio: bio}
      hash.delete_if {|key,value| value == nil}
      hash
  end

end

