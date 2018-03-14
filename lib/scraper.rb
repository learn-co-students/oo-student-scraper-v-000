require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.roster-cards-container").each do |container|
      container.css(".student-card a").each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile = "#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students_info = {}
    profile = Nokogiri::HTML(open(profile_url))

    links = profile.css("div.social-icon-container a").collect {|a| a.attribute("href").value}

    links.each do |link|
      case
      when link.include?("twitter")
        students_info[:twitter] = link
      when link.include?("linkedin")
        students_info[:linkedin] = link
      when link.include?("github")
        students_info[:github] = link
      else
        students_info[:blog] = link
      end
      students_info[:profile_quote] = profile.css(".profile-quote").text
      students_info[:bio] = profile.css(".bio-block .description-holder p").text
    end
    students_info
  end

end
