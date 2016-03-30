require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      students << student_hash = {
       :name => student.css(".student-name").text,
       :location => student.css("p.student-location").text,
       :profile_url => "#{index_url}" + student.css("a").attribute("href").text
      }
    #students << student_hash
   end
    students
end
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    doc.css(".social-icon-container a").each do |student|
      student_social = student.attribute("href").text
        student_hash[:twitter] = student_social if student_social.include?("twitter")
        student_hash[:linkedin] = student_social if student_social.include?("linkedin")
        student_hash[:github] = student_social if student_social.include?("github")
        student_hash[:blog] = student_social if student.css("img").attribute("src").text.include?("rss")
       end
        student_hash[:profile_quote] = doc.css(".profile-quote").text
        student_hash[:bio] = doc.css(".description-holder p").text
        student_hash
  end

end

