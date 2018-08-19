require 'open-uri'
require 'pry'
require 'nokogiri'
#students: doc.css("div.student-card")
#name: student.css("a div.card-text-container h4.student-name").text
#location: student.css("div.card-text-container p.student-location").text
#profile_url: student.css("a").attribute("href").value
#student profile page
#profile_name: student_profile.css("div.vitals-text-container h1.profile-name").text
#profile_location: student_profile.css("div.vitals-text-container h2.profile-location").text
#profile_quote: student_profile.css("div.vitals-text-container div.profile-quote").text
#social_icons: student_profile.css("div.social-icon-container a") this is where all the social icons are. you may need to iterate over each perhaps.
#social_icon_container.css("a")
# student_profile.css("div.social-icon-container a").collect{ |icon| icon.attribute("href").value }

#twitter_url:
#linkedin_url:
#github_url:
#blog_url:

#bio:
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css("div.student-card").each do |student|
      students << {
        :name => student.css("a div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_profile = Nokogiri::HTML(html)
    binding.pry
  end

end


social_icon_container
