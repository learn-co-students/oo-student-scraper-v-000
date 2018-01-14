require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper
  attr_accessor :name, :location, :profile_url, :twitter_url, :linkedin_url, :github_url, :blog_url, :profile_quote, :bio

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".student-card").collect do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a").attr("href").value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_hash = {}
    doc.css(".vitals-container").each do |student|
      student_hash[:profile_quote] = student.css(".profile-quote").text
      student_hash[:bio] = student.css("h6").text
      student.css(".social-icon-container a").each do |type|
          link = type.attr("href")
          if link.include? "twitter"
            student_hash[:twitter_url] = link
          elsif link.include? "linkedin"
            student_hash[:linkedin_url] = link
          elsif link.include? "github"
            student_hash[:github_url] = link
          else
            student_hash[:blog_url] = link
          end
        end
      end
      student_hash
    end
  end
