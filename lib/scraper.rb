require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    begin
      html = Nokogiri::HTML(open(index_url))

      html.css(".student-card").each do |student|
        students << {
          name: student.css("h4.student-name").text,
          location: student.css(".student-location").text,
          profile_url: "http://students.learn.co/#{student.css("a").attr("href").value}"
        }
      end
    rescue OpenURI::HTTPError => e
      puts "Couldn't find #{index_url}"
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    begin
      html = Nokogiri::HTML(open(profile_url))
      social_details = html.css(".social-icon-container a").collect { |node| node.attr("href") }

      student = {
        twitter: social_details.find { |node| node.include?("twit") },
        linkedin: social_details.find { |node| node.include?("link") },
        github: social_details.find { |node| node.include?("git") },
        blog: social_details.find { |node| node.include?("rss") },
        profile_quote: html.css(".profile_quote").text,
        bio: html.css(".bio-content .description-holder").text.chomp
      }
    rescue OpenURI::HTTPError => e
      puts "Couldn't find #{profile_url}"
      student = {}
    end
    student
  end
end

