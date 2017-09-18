require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    # return the array of student hashes
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student = {}

    if profile_page.css('div.social-icon-container a[href*="twitter"]').length != 0
      student[:twitter] = profile_page.css('div.social-icon-container a[href*="twitter"]').attribute("href").value
    end

    if profile_page.css('div.social-icon-container a[href*="linkedin"]').length != 0
      student[:linkedin] = profile_page.css('div.social-icon-container a[href*="linkedin"]').attribute("href").value
    end

    if profile_page.css('div.social-icon-container a[href*="github"]').length != 0
      student[:github] = profile_page.css('div.social-icon-container a[href*="github"]').attribute("href").value
    end

    if profile_page.css('div.social-icon-container a:nth-child(4)').length != 0
      student[:blog] = profile_page.css('div.social-icon-container a:nth-child(4)').attribute("href").value
    end

    student[:profile_quote] = profile_page.css("div.profile-quote").text
    student[:bio] = profile_page.css("div.description-holder p").text


    # return the student hash
    student
  end

end
