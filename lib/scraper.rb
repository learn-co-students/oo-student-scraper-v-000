require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []

    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    student_area = doc.css(".student-card")
    # student_area = doc.css(".card-text-container")
    student_area.each do |x|
       students_name_hash = {}
       students_name_hash[:name] = x.css(".card-text-container h4").text
       students_name_hash[:location] = x.css(".card-text-container p").text
       students_name_hash[:profile_url] = x.css("a").first["href"]
        students_array << students_name_hash
    end
      students_array
    end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    # profile_hash[:twitter] = []
    # profile_hash[:linkedin] = []
    # profile_hash[:github] = []
    # profile_hash[:blog] = []
    # profile_hash[:profile_quote] = []
    # profile_hash[:bio] = []
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    info_area = doc.css(".main-wrapper")
    info_area.each do |x|
      profile_hash[:twitter] = x.css(".vitals-container .social-icon-container a").first["href"]
      profile_hash[:linkedin] = x.css(".vitals-container .social-icon-container a")[1]["href"]
      profile_hash[:github] =x.css(".vitals-container .social-icon-container a")[2]["href"]
      profile_hash[:blog] = x.css(".vitals-container .social-icon-container a")[3]["href"]
      profile_hash[:profile_quote] = x.css(".vitals-container .vitals-text-container .profile-quote").text
      profile_hash[:bio] = x.css(".details-container .description-holder p").text

      # --GETS ALL SOCIAL MEDIA LINKS--
      # social_media_links = x.css(".vitals-container .social-icon-container a")
      # social_media_links.each do |x|
      #   x["href"]
     end
    profile_hash
  end

end
