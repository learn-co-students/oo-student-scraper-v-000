require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index = Nokogiri::HTML(open(index_url))
    index.css("div.roster-cards-container").each do |container|
      container.css(".student-card a").each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile = "#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile}
      end
    end
    students
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    students_profile = {}

    social = profile.css("div.social-icon-container a").collect {|a| a.attribute("href").value}
    social.each do |link|
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
