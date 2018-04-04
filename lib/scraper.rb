require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_array = []

    doc.css("div.student-card").each do |student|
      student_info = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      student_array << student_info
    end
    student_array
  end


  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    #binding.pry
    #student_profiles[:profile_quote] = doc.css("div.profile-quote").text
      #student_profiles[:bio] = doc.css("div.description-holder p").text

scraped_student = {}
    doc.css(".social-icon-container a").each do |social_icon|
    profile_page = "#{social_icon.attr("href")}"
      if profile_page.include?("twitter")
        scraped_student[:twitter] = profile_page
      elsif profile_page.include?("linkedin")
      scraped_student[:linkedin] = profile_page
    elsif profile_page.include?("github")
      scraped_student[:github] = profile_page
    else
      scraped_student[:blog] = profile_page
    end # end if/else condition
    #binding.pry
    profile_quote = doc.css(".profile-quote").text
        bio_p = doc.css(".bio-content p").text

        scraped_student[:profile_quote] = profile_quote
        scraped_student[:bio] = bio_p

  end #end iteration
  scraped_student
end #end class method

end #end class
