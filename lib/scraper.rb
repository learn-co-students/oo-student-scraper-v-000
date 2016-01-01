require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))
    base = "http://students.learn.co/"
    data.css(".student-card").map do |student| 
      student_hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: URI.join(base, student.css("a").attribute("href").value).to_s
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    data = Nokogiri::HTML(open(profile_url))
    twitter = data.css(".social-icon-container a[href*='twitter']")
    linkedin = data.css(".social-icon-container a[href*='linkedin']")
    github = data.css(".social-icon-container a[href*='github']")
    blog = data.css(".social-icon-container a:nth-child(4)")
    attributes = {
      twitter: twitter.attribute("href").value ||= nil,
      linkedin: linkedin.attribute("href").value ||= nil,
      github: github.attribute("href").value ||= nil,
      blog: blog.attribute("href").value ||= nil,
      profile_quote: data.css(".profile-quote").text,
      bio: data.css(".bio-content .description-holder p").text
    }
  end

end

