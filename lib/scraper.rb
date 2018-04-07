require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    student_hash = {}
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".student-card").each do |student|
# binding.pry
    student_hash = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.css("@href").first.value,
    }

    students_array << student_hash
    end
    students_array

  end


  def self.scrape_profile_page(profile_url)
    student_hash = {}
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)

    doc.css("div.main-wrapper.profile .social-icon-container a").each do |profile|
      if profile.attribute("href").value.include?("twitter")
        student_hash[:twitter] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("github")
        student_hash[:github] = profile.attribute("href").value
      else
        student_hash[:blog] = profile.attribute("href").value
      end #end of if/elsif
    end #end of do

    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text

    student_hash
  end

end
