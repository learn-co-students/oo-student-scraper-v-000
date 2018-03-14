require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #link: ("a").attribute("href").value
    #name: ("h4.student-name").text
    #location: ("p.student-location").text
    students = []

    doc.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}

    social = doc.css("div.vitals-container a")
    #example of social
    #<a href="https://twitter.com/jmburges"><img class="social-icon" src="../assets/img/twitter-icon.png"></a>
    #<a href="https://www.linkedin.com/in/jmburges"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>
    #<a href="https://github.com/jmburges"><img class="social-icon" src="../assets/img/github-icon.png"></a>
    #<a href="http://joemburgess.com/"><img class="social-icon" src="../assets/img/rss-icon.png"></a>
    
    #adds social to hash if student has one
    social.each {|x| profile[:twitter] = x.attribute("href").value if x.to_s.match(/twitter/)}
    social.each {|x| profile[:linkedin] = x.attribute("href").value if x.to_s.match(/linkedin/)}
    social.each {|x| profile[:github] = x.attribute("href").value if x.to_s.match(/github/)}
    social.each {|x| profile[:blog] = x.attribute("href").value if x.to_s.match(/rss/)}
    #adds quote
    profile[:profile_quote] = doc.css("div.profile-quote").text
    #adds bio
    profile[:bio] = doc.css("div.bio-content p").text

    profile
  end

end

