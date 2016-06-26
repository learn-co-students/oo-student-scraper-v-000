require 'open-uri'
# require 'nokogiri'
require 'pry'


class Scraper

  attr_accessor :name, :location, :profile_url


  def self.scrape_index_page(index_url)
    domain = index_url[/^(?:http:\/\/|www\.|https:\/\/)([^\/]+)/]
    doc = Nokogiri::HTML(open(index_url))
    students_from_index = []

    students_data = doc.css(".student-card")

    students_data.collect do |item|
      profile_url = item.css("a").attr("href").value
      student = {
        :name => item.css(".card-text-container h4").text,
        :location => item.css(".card-text-container p").text,
        :profile_url => "#{domain}/#{profile_url}"
      }
      students_from_index << student
    end
    students_from_index
  end

  def self.scrape_profile_page(profile_url)
    student_profile_url = {}
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css(".social-icon-container")

    social_links.collect do |item|
      link_social = item.css(".social-icon")
      links = link_social.xpath('//div/a/@href')

      links.each do |link|
        # binding.pry
        if link.value.include?("twitter")
          student_profile_url[:twitter] = link.value
        elsif link.value.include?("linkedin")
          student_profile_url[:linkedin] = link.value
        elsif link.value.include?("github")
          student_profile_url[:github] = link.value
        else
          student_profile_url[:blog] = link.value
        end
      end
    end

    student_profile_url[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student_profile_url[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")

    student_profile_url
  end

end







