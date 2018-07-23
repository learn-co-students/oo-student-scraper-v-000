require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_link = student.attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students

  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_profile = []
    icon = profile_page.css(".social-icon-container a")

    if icon.css(".social-icon").attribute("src").value == "../assets/img/twitter-icon.png"
      icon.attribute("href").value = twitter_link
    elsif icon.css(".social-icon").attribute("src").value == "../assets/img/linkedin-icon.png"
      icon.attribute("href").value = linkedin_link
    elsif icon.css(".social-icon").attribute("src").value == "../assets/img/github-icon.png"
      icon.attribute("href").value = github_link
    elsif icon.css(".social-icon").attribute("src").value == "../assets/img/rss-icon.png"
       icon.attribute("href").value = blog_link
    end

    quote = profile_page.css(".profile-quote").text
    bio_para = profile_page.css(".details-container p").text
    student_profile << {twitter: twitter_link, linkedin: linkedin_link, github: github_link, blog: blog_link, profile_quote: quote, bio: bio_para}

    student_profile
    binding.pry
    end
end
