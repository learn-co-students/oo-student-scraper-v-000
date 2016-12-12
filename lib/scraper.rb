require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    #returns array of hashes, each of which contains a student
    scraped_students = Array.new
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student| #is this the correct collection to be iterating over?
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = "./fixtures/student-site/#{student.css("a").attr("href").text}"
      hash = {
        :name => name,
        :location => location,
        :profile_url => profile_url
      }
      scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    #returns a hash of attributes that contains a student's information
    scraped_student = {}

    profile = Nokogiri::HTML(open(profile_url))

    #binding.pry
    profile.css(".social-icon-container a").each do |link|
      if link.values[0].include?("twitter")
        scraped_student[:twitter] = link.values[0]
      elsif link.values[0].include?("linkedin")
        scraped_student[:linkedin] = link.values[0]
      elsif link.values[0].include?("github")
        scraped_student[:github] = link.values[0]
      else
        scraped_student[:blog] = link.values[0]
      end
    end

    if profile.css(".profile-quote") != nil
      scraped_student[:profile_quote] = profile.css(".profile-quote").text
    end

    if profile.css(".description-holder p").text != nil
      scraped_student[:bio] = profile.css(".description-holder p").text
    end
    
    scraped_student
  end

end
