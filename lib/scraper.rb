require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css('div.student-card').each_with_index do |student, index|
      name = student.css('.card-text-container .student-name').text
      location = student.css('.card-text-container .student-location').text
      profile_url = student.css('a').attribute('href').value

      student_index_array << {
        :name        => name,
        :location    => location,
        :profile_url => profile_url
      }
    end

    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    doc = Nokogiri::HTML(open(profile_url))

    doc.css('div.social-icon-container a').each do |social|
      link = social.attribute('href').value
      type = social.css('img').attribute('src').value
      title = type[/..\/assets\/img\/([^|]+)-icon.png/i, 1]
      title = (title == "rss" ? "blog" : title)
      scraped_student[title.to_s.to_sym] = link
    end

    profile_quote = doc.css('div.vitals-text-container .profile-quote').text
    bio = doc.css('div.details-container .bio-block .description-holder').text

    scraped_student[:profile_quote] = profile_quote.strip
    scraped_student[:bio]           = bio.strip
    scraped_student
  end

end
