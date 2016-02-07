require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student = Nokogiri::HTML(open(index_url))
    students = []
      student.css("div.student-card").each do |card|
      students << { :name => card.css("a div.card-text-container h4.student-name").text, :location => card.css("a div.card-text-container p.student-location").text, :profile_url => "http://127.0.0.1:4000/#{card.css("a").attr('href')}"
          }
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    studentprofile = {}
    social = profile.css(".social-icon-container").children.css("a").map { |link| link.attribute('href').value}

      social.each do |link|
        if link.include?("linkedin")
          studentprofile[:linkedin] = link
        elsif link.include?("twitter")
          studentprofile[:twitter] = link
        elsif link.include?("github")
          studentprofile[:github] = link
        else
          studentprofile[:blog] = link
        end

        studentprofile[:profile_quote] = profile.css(".profile-quote").text
        studentprofile[:bio] = profile.css("div.bio-block p").text
      end
    studentprofile
  end

end



