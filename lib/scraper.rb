require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    student_array = []
    html = Nokogiri::HTML(open(index_url))

    html.css("div.student-card").each do |student|
      scraped_students = {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      student_array << scraped_students
    end
    # binding.pry
    student_array
  end

  def self.scrape_profile_page(profile_url)
    profile = {}

    html = Nokogiri::HTML(open(profile_url))

    socials = html.css("div.social-icon-container").children.css("a").collect {|x| x.attribute("href").value}

    socials.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = html.css("div.profile-quote").text if html.css("div.profile-quote").text
    profile[:bio] = html.css("div.bio-content.content-holder div.description-holder p").text if html.css("div.bio-content.content-holder div.description-holder p").text
    profile

  end

end
