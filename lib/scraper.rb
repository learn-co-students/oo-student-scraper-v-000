require 'open-uri'
require 'pry'
require "nokogiri"
class Scraper

  def self.scrape_index_page(index_url)
    students = []
    student_hash = {}
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      student_hash = {}
      student_hash[:name] = card.css(".student-name").text
      student_hash[:location] = card.css(".student-location").text
      student_hash[:profile_url] = card.css("a")[0]["href"]
      students.push(student_hash)
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    container = {}
    doc = Nokogiri::HTML(open(profile_url))

    doc.css(".social-icon-container a").each do |link|
        profile[:twitter] = link["href"] if link["href"].match(/(twitter)/)
        profile[:linkedin] = link["href"] if link["href"].match(/(linkedin)/)
        profile[:github] = link["href"] if link["href"].match(/(github)/)
        profile[:blog] = link["href"] if !link["href"].match(/(twitter|linkedin|github)/)
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css("p").text
    container.merge(profile)
  end

end
