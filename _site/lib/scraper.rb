require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
   

  def self.scrape_index_page(index_url)
      student_array = []
      
      doc = Nokogiri::HTML(open(index_url))

      doc.search(".student-card").each do |student|
        student_array <<  {

      name: student.search("h4.student-name").text,
      location:  student.search("p.student-location").text,
      profile_url: "http://students.learn.co/#{student.search("a").attribute("href").value}"
          }
    end
      student_array
  end

  def self.scrape_profile_page(profile_url)
    specific_student = {}
    doc = Nokogiri::HTML(open(profile_url))
    
    doc.search(".social-icon-container a").each do |social|
      if social.attribute("href").value.scan(/twitter/) == ["twitter"]
          specific_student[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.scan(/linkedin/) == ["linkedin"]
          specific_student[:linkedin] = social.attribute("href").value
      elsif  social.attribute("href").value.scan(/github/) == ["github"]
          specific_student[:github] = social.attribute("href").value
      else 
          specific_student[:blog] = social.attribute("href").value
        end
      end
   
    specific_student[:profile_quote] =  doc.search(".vitals-container").search(".profile-quote").text
    specific_student[:bio] =  doc.search(".description-holder").search("p").text

    specific_student
   
  end

end

