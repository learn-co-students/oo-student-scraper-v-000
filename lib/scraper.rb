require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      students << { 
        :name => student.css("a div.card-text-container h4.student-name").text, 
        :location => student.css("a div.card-text-container p.student-location").text, 
        :profile_url => index_url + student.css("a").attribute("href").value 
      }
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_data = {}
    twitter = doc.css("div.vitals-container div.social-icon-container a[href*='twitter']")
    student_data[:twitter] = twitter.attribute("href").value unless twitter.empty?
    linkedin = doc.css("div.vitals-container div.social-icon-container a[href*='linkedin']")
    student_data[:linkedin] = linkedin.attribute("href").value unless linkedin.empty?
    github = doc.css("div.vitals-container div.social-icon-container a[href*='github']")
    student_data[:github] = github.attribute("href").value unless github.empty?
    blog = doc.css("div.vitals-container div.social-icon-container a:has(img[src*='rss'])")
    student_data[:blog] = blog.attribute("href").value unless blog.empty?
    student_data[:profile_quote] = doc.css("div.vitals-container div.vitals-text-container div.profile-quote").text
    student_data[:bio] = doc.css("div.details-container div.bio-block.details-block div.bio-content.content-holder div.description-holder p").text
    student_data
  end

end


