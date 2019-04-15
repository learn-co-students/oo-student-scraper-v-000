require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  #responsible for scraping the index page that lists all of the students

  #This is a class method that should take in an argument of the URL of the index page,
  #for the purposes of our test the URL will be "./fixtures/student-site/index.html".
  #It should use Nokogiri and Open-URI to access that page.
  #The return value of this method should be an array of hashes in which each hash
  #represents a single student. The keys of the individual student hashes should be
  # :name, :location and :profile_url.
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    scraped_students = []

    index_page.css("div.student-card").each do |student|
      scraped_students.push(name: student.css("h4.student-name").text, location: student.css("p.student-location").text, profile_url: student.css("a").attribute("href").value)
    end

    scraped_students
  end

  #responsible for scraping an individual student's profile page to get further
  #information about that student. The only attributes you need to scrape from a
  #student's profile page are: twitter url, linkedin url, github url, blog url, profile quote, and bio.
  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
=begin
    profile_page.css("div.main-wrapper.profile").each do |detail|
      position = profile_page.css("div.main-wrapper.profile").css("a").count
      name = detail.css("a").attribute("href")[position + 1].value
      scraped_student[name.to_sym] = profile_page.css("div.main-wrapper.profile").css("a").attribute("href").value
    end
=end
    #position = profile_page.css("div.main-wrapper.profile").css("a").count
    #profile_page.css("div.main-wrapper.profile").css("a").include?("twitter")
    #profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value.include?("twitter")
    unless profile_page.css("div.main-wrapper.profile").css("a")[1].nil?
      if profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value.include?("twitter")
        scraped_student[:twitter] = profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value.include?("linkedin")
        scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value.include?("github")
        scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value
      else
        scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value
      end
    end

    unless profile_page.css("div.main-wrapper.profile").css("a")[2].nil?
      if profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value.include?("twitter")
        scraped_student[:twitter] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value.include?("linkedin")
        scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value.include?("github")
        scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
      else
        scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
      end
    end

    unless profile_page.css("div.main-wrapper.profile").css("a")[3].nil?
      if profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value.include?("twitter")
        scraped_student[:twitter] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value.include?("linkedin")
        scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value.include?("github")
        scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
      else
        scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
      end
    end

    unless profile_page.css("div.main-wrapper.profile").css("a")[4].nil?
      if profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value.include?("twitter")
        scraped_student[:twitter] = profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value.include?("linkedin")
        scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value
      elsif profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value.include?("github")
        scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value
      else
        scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value
      end
    end


=begin
      scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
      scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
      scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value

    elsif profile_page.css("div.main-wrapper.profile").css("a")[1] == nil && profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value.include?("twitter") == false
      scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value
      scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
      scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
    end

    unless profile_page.css("div.main-wrapper.profile").css("a")[1].nil?
      scraped_student[:twitter] = profile_page.css("div.main-wrapper.profile").css("a")[1].attribute("href").value
    end
    unless profile_page.css("div.main-wrapper.profile").css("a")[2].nil?
      scraped_student[:linkedin] = profile_page.css("div.main-wrapper.profile").css("a")[2].attribute("href").value
    end
    unless profile_page.css("div.main-wrapper.profile").css("a")[3].nil?
      scraped_student[:github] = profile_page.css("div.main-wrapper.profile").css("a")[3].attribute("href").value
    end
    unless profile_page.css("div.main-wrapper.profile").css("a")[4].nil?
      scraped_student[:blog] = profile_page.css("div.main-wrapper.profile").css("a")[4].attribute("href").value
    end
=end
    scraped_student[:profile_quote] = profile_page.css("div.main-wrapper.profile").css("div.profile-quote").text
    scraped_student[:bio] = profile_page.css("div.main-wrapper.profile").css("div.bio-content.content-holder p").text

    scraped_student
  end
end
