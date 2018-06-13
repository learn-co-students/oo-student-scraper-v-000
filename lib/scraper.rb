require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    index = Nokogiri::HTML(open(index_url))
    index.css("div.roster-cards-container").each do |container|
      container.css(".student-card a").each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile_url = "#{student.attr('href')}"
        student_array << {name: name, location: location, profile_url: profile_url}
      end
    end
      student_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    students_profile = {}
    social_media = profile.css("div.social-icon-container a").collect {|a| a.attribute("href").value}
    social_media.each do |link|
      case
      when link.include?("twitter")
        students_profile[:twitter] = link
      when link.include?("linkedin")
        students_profile[:linkedin] = link
      when link.include?("github")
        students_profile[:github] = link
      else
        students_profile[:blog] = link
      end
        students_profile[:profile_quote] = profile.css("div.profile-quote").text
        students_profile[:bio] = profile.css(".bio-block .description-holder p").text
    end
    students_profile
  end

end

