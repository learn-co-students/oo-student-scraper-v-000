require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |post|
      scraped_students << {
        :name => post.css("div.card-text-container h4.student-name").text,
        :location => post.css("div.card-text-container p.student-location").text,
        :profile_url => post.css("a")[0]["href"]
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    doc = Nokogiri::HTML(open(profile_url))
    sites = doc.css(".social-icon-container a[href]")
    new_site = sites.map { |link| link['href'] }

    name = doc.css(".vitals-text-container h1.profile-name").text

    twitter_url = new_site.select { |link| link.include?("twitter") }
    if twitter_url != []
      scraped_student[:twitter] = twitter_url[0]
    end

    linkedin_url = new_site.select { |link| link.include?("linkedin") }
    if linkedin_url != []
      scraped_student[:linkedin] = linkedin_url[0]
    end

    git_url = new_site.select { |link| link.include?("github") }
    if git_url != []
      scraped_student[:github] = git_url[0]
    end

    blog_url = new_site.select { | link| link != twitter_url[0] && link != linkedin_url[0] && link != git_url[0] }
    if blog_url != []
      scraped_student[:blog] = blog_url[0]
    end

    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css(".description-holder p").text
    scraped_student
  end

end
