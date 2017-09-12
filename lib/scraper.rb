require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css("div.student-card").each do |student|
      new_student = {}
      new_student[:name] = student.css("div.card-text-container h4.student-name").text
      new_student[:location] = student.css("div.card-text-container p.student-location").text
      new_student[:profile_url] = student.css("a").attribute("href").value
      students << new_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_info = {}
    html = open(profile_url)
    student_page = Nokogiri::HTML(html)

    social_links = student_page.css("div.vitals-container div.social-icon-container a").collect {|link| link.attribute("href").value}
    twitter = social_links.detect {|link| link.include?("twitter")}
    linkedin = social_links.detect {|link| link.include?("linkedin")}
    github = social_links.detect {|link| link.include?("github")}
    blog = social_links.detect {|link| !link.include?("twitter") && !link.include?("linkedin") && !link.include?("github") && !link.include?("facebook")}
    if twitter
      student_info[:twitter] = twitter
    end
    if linkedin
      student_info[:linkedin] = linkedin
    end
    if github
      student_info[:github] = github
    end
    if blog
      student_info[:blog] = blog
    end
    student_info[:profile_quote] = student_page.css("div.vitals-text-container div.profile-quote").text
    student_info[:bio] = student_page.css("div.bio-content.content-holder div.description-holder p").text

    student_info
  end

end
