require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    all_students = []

    students.each do |student|
      new_student = {}
      new_student[:name] = student.css(".student-name").text
      new_student[:location] = student.css(".student-location").text
      new_student[:profile_url] = student.css("a")[0]["href"]
      all_students << new_student
    end

    all_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}

    #grabbing socials
    links = doc.css("a")
    student_info[:twitter] = social_grabber(links, "twitter")["href"]
    student_info[:linkedin] = social_grabber(links, "linkedin")["href"]
    student_info[:github] = social_grabber(links, "github")["href"]

    #grabbing blog, profile quote, and bio
    student_info[:blog] = blog_grabber(links, doc)["href"]
    student_info[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_info[:bio] = doc.css(".bio-content .description-holder p").text
    student_info.delete_if {|k, v| v == nil}

    student_info
  end

  def self.social_grabber(links, platform)
    cor_obj = links.detect {|link| link["href"].include?("#{platform}")}
    cor_obj ? cor_obj : ""
  end

  def self.blog_grabber(links, doc)
    cor_obj = links.detect do |link|
      link["href"] != social_grabber(links, "twitter")["href"] &&
      link["href"] != social_grabber(links, "linkedin")["href"] &&
      link["href"] != social_grabber(links, "github")["href"] &&
      link["href"].include?(".com")
    end
    cor_obj ? cor_obj : ""
  end


end
