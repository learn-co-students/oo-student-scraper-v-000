require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = Array.new

    html = open(index_url)
    students = Nokogiri::HTML(html)

    students.css(".student-card").each do |s|
      student_name = s.css("h4.student-name").text
      student_location = s.css("p.student-location").text
      profile_url = "./fixtures/student-site/#{s.css("a").attr("href").text}"

      scraped_students << {name: student_name, location: student_location, profile_url: profile_url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    profile.css(".vitals-container").each do |info|
      if info.css(".social-icon-container a").attr("href").text.include?("twitter")
        twitter = info.css(".social-icon-container a").attr("href").text
        scraped_student[:twitter] = twitter
      end

      if info.css(".social-icon-container a").attr("href").text.include?("linkedin")
        linkedin = info.css(".social-icon-container a").attr("href")
        scraped_student[:linkedin] = linkedin
      end

      if info.css(".social-icon-container a").attr("href").text.include?("github")
        github = info.css(".social-icon-container a").attr("href")
        scraped_student[:github] = github
      end

      if info.css(".social-icon-container a").attr("href").text.include?("flatiron")
        blog = info.css(".social-icon-container a").attr("href")
        scraped_student[:blog] = blog
      end

      quote = info.css(".vitals-text-container .profile-quote").text
      scraped_student[:profile_quote] = quote
    end

    profile.css(".details-container").each do |info|
      bio = info.css(".description-holder p").text
      scraped_student[:bio] = bio
    end

  scraped_student
  end

end
