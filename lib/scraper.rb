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
    main_wrapper = doc.css(".main-wrapper")

      # --GETS ALL SOCIAL MEDIA LINKS--

      links_array = []
      social_media_links = {}
       main_wrapper.each do |x|
        space = x.css(".vitals-container .social-icon-container a")
      space.each do |x|
      links_array << x["href"]
     end
     end
     links_array.each do |x|
       if x.include?("twitter")
         profile_hash[:twitter] = x
      elsif x.include?("linkedin")
        profile_hash[:linkedin] = x
      elsif x.include?("github")
        profile_hash[:github] = x
      elsif x.include?("youtube")
        profile_hash[:youtube] = x
      end
    end

   #--GETS BLOG, QUOTE, BIO --

    main_wrapper.each do |x|
      if x.css(".vitals-container .social-icon-container a")[3]
        if x.css(".vitals-container .social-icon-container a")[3]["href"].include?("http")
          profile_hash[:blog] = x.css(".vitals-container .social-icon-container a")[3]["href"]
      end
      end
      profile_hash[:profile_quote] = x.css(".vitals-container .vitals-text-container .profile-quote").text
      profile_hash[:bio] = x.css(".details-container .description-holder p").text
    end
    profile_hash
  end

end
