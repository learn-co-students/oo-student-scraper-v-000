require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)

    scraped_students = []

    index_page.css("div.student-card").each do |student|
      scraped_students <<  {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "./fixtures/student-site/" + student.css("a").attribute("href").value
      }
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    student_social = {}

    profile.css("div.social-icon-container a").each { |item|
      if (item.attribute("href").value).include?("twitter")
        student_social[:twitter]= item.attribute("href").value
      elsif (item.attribute("href").value).include?("linkedin")
        student_social[:linkedin]= item.attribute("href").value
      elsif (item.attribute("href").value).include?("github")
        student_social[:github]= item.attribute("href").value
      else
        student_social[:blog] = item.attribute("href").value
      end
    }

    student_social[:profile_quote] = profile.css("div.profile-quote").text
    student_social[:bio] = profile.css("div.bio-content div.description-holder p").text

    student_social
  end

end
