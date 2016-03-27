require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    student_arr = []

    all_students = site.css("div.roster-cards-container")
    students = all_students.css("div.student-card")
    students.each do |student|
      profile = {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => (index_url + student.css("a").attr('href').value)
        }
      student_arr << profile
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    site = Nokogiri::HTML(open(profile_url))
    main = site.css("div.vitals-container")
    details = site.css("div.details-container")
    socials = main.css("div.social-icon-container").children.to_a
    student = {
      :profile_quote => main.css("div.profile-quote").inner_text,
      :bio => details.css("div.bio-content.content-holder div.description-holder p").text
    }

    socials.each do |element|
      if element.class.to_s == "Nokogiri::XML::Element"
        url = element["href"]
        src = element.first_element_child["src"].match(/(?:img\/)([a-zA-Z]*)(?:-icon)/)
      end
      if src
        if src[1] == "github"
          student[:github] = url
        elsif src[1] == "linkedin"
          student[:linkedin] = url
        elsif src[1] == "twitter"
          student[:twitter] = url
        elsif src[1] == "rss"
          student[:blog] = url
        end
      end
    end
    student
  end

end