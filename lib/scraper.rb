require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc =  Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] =  student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      profile_url_path = student.css("a").attribute("href").value
      student_hash[:profile_url] = index_url + profile_url_path
      scraped_students << student_hash
    end
    scraped_students
  end

  def self.get_social_links(links, student_hash)
    links.each do |link|
      url = link.attribute("href").value
      img_src = link.css("img").attribute("src").value
      if img_src.include?("twitter")
        student_hash[:twitter] = url
      elsif img_src.include?("linkedin")
        student_hash[:linkedin] = url
      elsif img_src.include?("github")
        student_hash[:github] = url
      elsif img_src.include?("rss")
        student_hash[:blog] = url
      end
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    doc =  Nokogiri::HTML(open(profile_url))
    student_hash = {}
    student_hash = self.get_social_links(doc.css(".social-icon-container a"), student_hash)
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-block .description-holder p").text
    student_hash
  end

end

