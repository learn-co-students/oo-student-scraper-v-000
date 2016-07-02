require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.roster-cards-container").each do |roster|
      roster.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_url = "./fixtures/student-site/#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # twitter url .social-icon-container a   // .attr('href').value
    # linkedin url .social-icon-container a  // .attr('href').value
    # github url .social-icon-container a   // .attr('href').value
    # blog url .social-icon-container a  // .attr('href').value
    # profile quote .vitals-text-container .profile-quote //  .text
    # bio div.description-holder p // .text
    profile_page = Nokogiri::HTML(open(profile_url))

    profile = {}

    # \b(\w+)\.\b   regex for matching text after http://
    links = profile_page.css('div.vitals-container .social-icon-container a').map {|value| value.attr('href')}

    links.each do |href|
      if href.include?("twitter")
        profile[:twitter] = href
      elsif href.include?("linkedin")
        profile[:linkedin] = href
      elsif href.include?("github")
        profile[:github] = href
      else
        profile[:blog] = href
      end
    end

    profile[:profile_quote] = profile_page.css('.vitals-text-container .profile-quote').text
    profile[:bio] = profile_page.css('div.description-holder p').text

    profile
  end

end
