require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      html = open(index_url)
      doc = Nokogiri::HTML(html)
      array = []
      doc.css("div.student-card").each do |student|
            x = { :name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => "#{index_url}#{student.css("a").attr("href").value}" }
            array << x
      end
    array
  end

  def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      doc = Nokogiri::HTML(html)
      hash = {}
    doc.css("div.social-icon-container a").each do |element|
  if element.css("img").attr("src").value.to_s == "../assets/img/twitter-icon.png"
    hash[:twitter] = element.attr("href")
  elsif element.css("img").attr("src").value.to_s == "../assets/img/linkedin-icon.png"
    hash[:linkedin] = element.attr("href")
  elsif element.css("img").attr("src").value.to_s == "../assets/img/github-icon.png"
    hash[:github] = element.attr("href")
  elsif element.css("img").attr("src").value.to_s == "../assets/img/rss-icon.png"
    hash[:blog] = element.attr("href")
    end
  end

  hash[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
  hash[:bio] = doc.css("div.bio-content p").text
  puts hash
   hash
  end

end

#Scraper.scrape_profile_page("http://127.0.0.1:4000/students/jenny-yamada.html")

