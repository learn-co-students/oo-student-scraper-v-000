require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      { name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attr("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    person = {}
    person[:profile_quote] = html.css(".profile-quote").text
    person[:bio] = html.css(".bio-content p").text

    html.css(".social-icon-container a").each do |a|
      link = a["href"]

      if link.include?("linkedin.com")
        person[:linkedin] = link
      elsif link.include?("github.com")
        person[:github] = link
      elsif link.include?("twitter.com")
        person[:twitter] = link
      elsif link.include?("youtube.com")
        person[:youtube] = link
      else
        person[:blog] = link
      end
    end
    person
  end

end
