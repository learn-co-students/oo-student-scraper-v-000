require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "./fixtures/student-site/index.html")
    # @index_url = index_url
    ### each element of students array to be a hash of a student card, with :name, :location, and :profile_url keys
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_card = doc.css("div.roster-cards-container div.student-card")
    student_card.each do |student_info|
      student = Hash.new
      student[:name] = student_info.css("h4").text
      student[:location] = student_info.css("p").text
      student[:profile_url] = student_info.css("a").attribute("href").value
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    ### :twitter_url, :linkedin_url, :github_url, :blog_url, :profile_quote, and :bio
    student_hash = Hash.new
    social = doc.search("div.social-icon-container a")
    social.each do |a|
        if a.attribute("href").value.include?("twitter")
          student_hash[:twitter] = a.attribute("href").value
        elsif a.attribute("href").value.include?("linkedin")
          student_hash[:linkedin] = a.attribute("href").value
        elsif a.attribute("href").value.include?("github")
          student_hash[:github] = a.attribute("href").value
        elsif (a.attribute("href").value != student_hash[:twitter] || a.attribute("href").value != student_hash[:linkedin] || a.attribute("href").value != student_hash[:github])
          student_hash[:blog] = a.attribute("href").value
        end
    end
    student_hash[:profile_quote] = doc.search("div.vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.search("div.details-container div.bio-content div.description-holder p").text
    student_hash

  end

end
