require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    students = page.css(".roster-cards-container .student-card")
    students_array = []

    students.each_with_index do |student, i|
      students_array[i] =
      { name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value }
    end

    students_array
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    details = page.css(".main-wrapper")
    student_hash = {}

    details.each do |detail|
      twitter_element = detail.css(".vitals-container .social-icon-container a[href *= twitter]")
      if twitter_element.length  >= 1 then student_hash[:twitter] = twitter_element.attribute("href").value end

      linkedin_element = detail.css(".vitals-container .social-icon-container a[href *= linkedin]")
      if linkedin_element.length  >= 1 then student_hash[:linkedin] = linkedin_element.attribute("href").value end

      github_element = detail.css(".vitals-container .social-icon-container a[href *= github]")
      if github_element.length  >= 1 then student_hash[:github] = github_element.attribute("href").value  end

      blog_element = detail.css(".vitals-container .social-icon-container a img[src *= rss]")
      if blog_element.length  >= 1 then student_hash[:blog] = blog_element.first.parent.attribute("href").value end

      profile_quote_element = details.css(".vitals-text-container .profile-quote")
      if profile_quote_element.length  >= 1 then student_hash[:profile_quote] = profile_quote_element.text end

      bio_element = detail.css(".details-container .bio-block .bio-content .description-holder p")
      if bio_element.length  >= 1 then student_hash[:bio] = bio_element.text end

    end

    #binding.pry
    # twitter url, linkedin url, github url, blog url, profile quote, and bio

    student_hash
  end

end
