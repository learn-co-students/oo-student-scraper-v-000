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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    info_area = doc.css(".main-wrapper")
    info_area.each do |x|
      profile_hash[:twitter] = x.css(".vitals-container .social-icon-container a").first["href"]
      binding.pry
      profile_hash[:linkedin] =
      profile_hash[:github] =
      profile_hash[:blog] =
      profile_hash[:profile_quote] =
      profile_hash[:bio] =
      social_media_links = x.css(".vitals-container .social-icon-container a")
      # social_media_links.each do |x| gets all social media links
      #   x["href"]
binding.pry
     end
      # twitter = x.css(".vitals-container .social-icon-container a").first["href"]

      binding.pry
    end


    profile_hash


  end

end
