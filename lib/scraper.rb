require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.search(".student-card").each do |student|
      students << {
        :name => student.search(".student-name").text,
        :location => student.search(".student-location").text,
        :profile_url => index_url + "/" + student.search("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    twitter = doc.search(".social-icon-container a[href*='twitter']")
    twitter.empty? ? twitter = nil : twitter = twitter.attribute("href").value

    linkedin = doc.search(".social-icon-container a[href*='linkedin']")
    linkedin.empty? ? linkedin = nil : linkedin = linkedin.attribute("href").value
    
    github = doc.search(".social-icon-container a[href*='github']")
    github.empty? ? github = nil : github = github.attribute("href").value
    
    blog = doc.search(".social-icon-container a:nth-child(4)")
    blog.empty? ? blog = nil : blog = blog.attribute("href").value

    student_links = {
      twitter: twitter,
      linkedin: linkedin,
      github: github,
      blog: blog,
      profile_quote: doc.search(".profile-quote").text,
      bio: doc.search(".description-holder p").text
    }
  end
end