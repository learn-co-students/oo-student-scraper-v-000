require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index)
    scraped_students = []
    index_page = Nokogiri::HTML(open(index))
    index_page.css("div .roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        student_profile = "./fixtures/student-site/#{student.attr('href')}"
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile}
    end
  end
  scraped_students
end


  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    social_icons = profile_page.css(".vitals-container .social-icon-container a")
    social_text = profile_page.css(".vitals-container .vitals-text-container")
    student_info = profile_page.css(".details-container")

    if social_icons.any? do |icon|
      if icon['href'].include?("twitter")
      scraped_student[:twitter] = icon['href']
    end
    end
  end

  if social_icons.any? do |icon|
    if icon['href'].include?("linkedin")
      scraped_student[:linkedin] = icon['href']
    end
  end
end

if social_icons.any? do |icon|
  if icon['href'].include?("github")
    scraped_student[:github] = icon['href']
  end
end
end

    scraped_student[:blog] = social_icons[3].attribute("href").value if social_icons[3]
    scraped_student[:profile_quote] = social_text.css(".profile-quote").text
    scraped_student[:bio] = student_info.css("div.bio-content.content-holder div.description-holder p").text
    scraped_student

  end
end
