require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        scraped_students << {
            :name => student.css("h4.student-name").text,
            :location => student.css("p.student-location").text,
            :profile_url => "./fixtures/student-site/#{student.attribute("href").value}"
          }
          end
        end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_students = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("body").each do |student|

      if student.css("div.social-icon-container a")[0].attribute("href").value.include?("twitter")
      scraped_students[:twitter] = student.css("div.social-icon-container a")[0].attribute("href").value
    elsif student.css("div.social-icon-container a")[0].attribute("href").value.include?("linkedin")
      scraped_students[:linkedin] = student.css("div.social-icon-container a")[0].attribute("href").value
    end
      if student.css("div.social-icon-container a")[1].attribute("href").value.include?("linkedin")
      scraped_students[:linkedin] = student.css("div.social-icon-container a")[1].attribute("href").value
    elsif student.css("div.social-icon-container a")[1].attribute("href").value.include?("github")
      scraped_students[:github] = student.css("div.social-icon-container a")[1].attribute("href").value
    end
      if student.css("div.social-icon-container a")[2]
      scraped_students[:github] = student.css("div.social-icon-container a")[2].attribute("href").value
    end
      if student.css("div.social-icon-container a")[3]
      scraped_students[:blog] = student.css("div.social-icon-container a")[3].attribute("href").value
    end
      scraped_students[:profile_quote] = student.css("div.profile-quote").text.strip
      scraped_students[:bio] = student.css("div.description-holder p").text.strip

    end
    scraped_students

  end

end
