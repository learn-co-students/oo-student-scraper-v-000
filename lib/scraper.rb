require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))
    data = data.css(".student-card")
    data.collect do | student_data |
      {name: student_data.css(".student-name").text, location: student_data.css(".student-location").text, profile_url: student_data.css("a").attr("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    data = Nokogiri::HTML(open(profile_url))
    social = data.css(".social-icon-container").css("a")
    social.each do | link |
      href = link.attr("href")
      if /twitter/.match(href)
        student[:twitter] = href
      elsif /linkedin/.match(href)
        student[:linkedin] = href
      elsif /github/.match(href)
        student[:github] = href
      elsif /youtube/.match(href)
      #  student[:youtube] = href
      else
        student[:blog] = href
      end
    end
    student[:profile_quote] = data.css(".profile-quote").text
    student[:bio] = data.css(".description-holder p").text
    student
  end

end
