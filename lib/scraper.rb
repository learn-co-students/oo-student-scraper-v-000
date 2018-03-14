require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_doc = Nokogiri::HTML(open(index_url))
    students_array = []
    index_doc.css("div.roster-cards-container").each do |student_card|
      student_card = index_doc.css(".student-card a").map do |student|
        students_array << {
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text,
          :profile_url => student.attr('href')
        }
      end
    end
    students_array
  end


  def self.scrape_profile_page(profile_url)
    student_info = {}
    profile_doc = Nokogiri::HTML(open(profile_url))

    student_info[:profile_quote] = profile_doc.css('.profile-quote').text
    student_info[:bio] = profile_doc.css('.bio-content p').text

    # Store the user's profile links.
    profile_links = profile_doc.css(".social-icon-container a")
    profile_links.each do |link|
      url = link.attr('href')

      if url.include?("linkedin")
        student_info[:linkedin] = url
      elsif url.include?("github")
        student_info[:github] = url
      elsif url.include?("twitter")
        student_info[:twitter] = url
      else
        student_info[:blog] = url
      end
    end

    return student_info
  end
end
