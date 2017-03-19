require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    html = File.read(index_url)
    student_scraper = Nokogiri::HTML(html)

    student_scraper.css("div.student-card").collect do |s|

      each_student = {
        :name => s.css("div.card-text-container h4.student-name").text,
        :location => s.css("div.card-text-container p.student-location").text,
        :profile_url => "./fixtures/student-site/#{s.css("a").attribute("href").value}"
      }
      student_index_array << each_student

    end

    student_index_array

  end

  def self.scrape_profile_page(profile_url)
    student_profile_array = []
    html = File.read(profile_url)
    student_scraper = Nokogiri::HTML(html)

    student_scraper.css("div.vitals-container").collect do |s|
      twitter_link = nil
      linkedin_link = nil
      github_link = nil
      bio = nil

      s.css("a").each do |h|
        link = h.attribute("href").value
        if link.include? "https://twitter.com/"
          twitter_link = link
        elsif link.include? "https://www.linkedin.com/"
          linkedin_link = link
        elsif link.include? "https://github.com"
          github_link = link
        else
          bio = link
        end
      end
      each_student = {
        :twitter => s.css("div.card-text-container h4.student-name").text,
        :linkedin => s.css("div.card-text-container p.student-location").text,
        :github => "./fixtures/student-site/#{s.css("a").attribute("href").value}",
        # :blog =>
        # :profile_quote =>
        # :bio =>

      }
      student_profile_array << each_student

    end

    student_profile_array

  end
end
