require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    #students: index_page.css(".student-card")
    #name: student.css(".student-name").text
    #location:student.css(".student-location").text
    #profile_url: student.css("a").attribute("href").value

    index_page.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student ={}
    
    #profile_quote: profile_page.css(".profile-quote").text
    #bio: profile_page.css(".description-holder p").text

    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".description-holder p").text

    # need to iterate through links to select blog href, may as well use it to assign github, linkedin, & twitter values too
    links = profile_page.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}

    links.each do |link|
      if link.include?('twitter')
        student[:twitter]= link
      elsif link.include?('linkedin')
        student[:linkedin] = link
      elsif link.include?('github')
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    
    student
  end

end

