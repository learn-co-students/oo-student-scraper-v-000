require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    # doc = Nokogiri::HTML(open(index_url))
    
    # scraped_students = []
    
    # doc.search(".student-card").each do |student|
    #   info = { 
    #     name: student.search(".student-name").text, 
    #     location: student.search(".student-location").text,
    #     profile_url: 
    #       student.search("a").map do |link|
    #         link.attribute('href').to_s
    #       end.uniq.sort.delete_if {|href| href.empty?}.join
    #   }
    #   scraped_students << info
    # end
    # scraped_students

    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    student = {}

    student[:bio] = profile.search(".bio-block .description-holder p").text

    student[:profile_quote] = profile.search(".profile-quote").text

    profile.search(".social-icon-container a").each do |link|
      if link['href'].include? "github.com"
        student[:github] = link['href']
      elsif link['href'].include? "linkedin.com"
        student[:linkedin] = link['href']
      elsif link['href'].include? "twitter.com"
        student[:twitter] = link['href']
      else 
        student[:blog] = link['href']
      end
    end

    student
  end

end

