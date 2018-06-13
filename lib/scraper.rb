require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read('./fixtures/student-site/index.html'))
    students = []
    index_page.css("div.student-card").each do |student_info|
      students << {
        :name => student_info.css("div.card-text-container h4.student-name").text,
        :location => student_info.css("div.card-text-container p.student-location").text,
        :profile_url => student_info.css("a").collect  { |link| link['href'] }.join
        }
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(File.read("#{profile_url}"))
    student = {}
    links = profile_page.css("div.social-icon-container a").collect { |link| link.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("facebook")
        student[:facebook] = link
      else
        student[:blog] = link
      end
      end
      student[:profile_quote] = profile_page.css("div.profile-quote").text
      student[:bio] = profile_page.css("div.bio-content div.description-holder p").text
      student
    end
=begin
<div class="profile-quote">"Reduce to a previously solved problem"</div>
</div>
</div>
<div class="details-container">
<div class="bio-block details-block">
<div class="bio-content content-holder">
  <div class="title-holder">
    <h3>Biography</h3>
  </div>
  <div class="description-holder">
    <p>I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School.</p>
  </div>
<div class="social-icon-container">
  <a href="https://twitter.com/jmburges"><img class="social-icon" src="../assets/img/twitter-icon.png"/></a>
  <a href="https://www.linkedin.com/in/jmburges"><img class="social-icon" src="../assets/img/linkedin-icon.png"/></a>
  <a href="https://github.com/jmburges"><img class="social-icon" src="../assets/img/github-icon.png"/></a>
  <a href="http://joemburgess.com/"><img class="social-icon" src="../assets/img/rss-icon.png"/></a>
=end
end
