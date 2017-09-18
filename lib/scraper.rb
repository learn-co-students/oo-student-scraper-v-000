require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    # return the array of student hashes
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    twitter_link = ""
    linkedin_link = ""
    github_link = ""
    blog_link = ""

    if profile_page.css('div.social-icon-container a[href*="twitter"]') != nil
      twitter_link = profile_page.css('div.social-icon-container a[href*="twitter"]').attribute("href").value
    end

    student = {
      :twitter => twitter_link,
      :linkedin => profile_page.css('div.social-icon-container a[href*="linkedin"]').attribute("href").value,
      :github => profile_page.css('div.social-icon-container a[href*="github"]').attribute("href").value,
      :blog => profile_page.css('div.social-icon-container a:nth-child(4)').attribute("href").value,
      :profile_quote => profile_page.css("div.profile-quote").text,
      :bio => profile_page.css("div.description-holder p").text
      #<img class="social-icon" src="../assets/img/linkedin-icon.png">
    }

    # return the student hash
    student
  end

end
