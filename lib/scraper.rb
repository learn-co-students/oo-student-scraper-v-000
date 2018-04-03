require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url) #returns students Array of hashes, each hash being a single student
    #keys: :name, :location, :profile_url
    students = []
    html = Nokogiri::HTML(open(index_url) )

    html.css("div.student-card").each { |card|
      name = card.css(".student-name").text
      location = card.css(".student-location").text
      profile_url = card.css("a").attribute("href").value
      student = { :name => name, :location => location, :profile_url => profile_url }
      students << student
    }
    students
  end

  def self.scrape_profile_page(profile_url) #returns a HASH, k/v's are student attributes.
    student_hash = {}
    html = Nokogiri::HTML(open(profile_url))
    #grab :twitter, :linkid, :github, :blog, :profile_quote, and :bio
    html.css(".social-icon-container a").each {|student|
      href = student.attribute("href").value #baseline to compare against
      if href.include?("twitter")
        student_hash[:twitter] = href
      elsif href.include?("linkedin")
        student_hash[:linkedin] = href
      elsif href.include?("github")
        student_hash[:github] = href
      else
        student_hash[:blog] = href
      end
    }
    student_hash[:profile_quote] = html.css(".profile-quote").text #standalone
    student_hash[:bio] = html.css(".description-holder p").text

    student_hash #return once filled

  end

end
