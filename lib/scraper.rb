
require 'open-uri'
require 'pry'


# The Scraper Class
# Let's start with the Scraper class in lib/scraper.rb. In this class you are responsible for defining two methods. The #scrape_index_page method is responsible for scraping the index page that lists all of the students and 

# The #scrape_index_page Method - responsible for scraping the index page that lists all of the students.  Class method.  should take in an argument of the URL of the index page, for the purposes of our test the URL will be "./fixtures/student-site/index.html". 

class Scraper

  def self.scrape_index_page(index_url)
    
    # binding.pry
    # It should use Nokogiri and Open-URI to access that page.
    
    index_page = Nokogiri::HTML(open(index_url))
    
    # The return value of this method should be an array of hashes in which each hash represents a single student.
    
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        
        # The keys of the individual student hashes should be :name, :location and :profile_url.
        
        student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end
  
  # The #scrape_profile_page method is responsible for scraping an individual student's profile page to get further information about that student. This is a class method that should take in an argument of a student's profile URL. It should use Nokogiri and Open-URI to access that page. The return value of this method should be a hash in which the key/value pairs describe an individual student. Some students don't have a twitter or some other social link. 

  def self.scrape_profile_page(profile_slug)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
    # # if profile_page.css(".social-icon-container").children.css("a")[0]
    # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
    # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
    # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end

