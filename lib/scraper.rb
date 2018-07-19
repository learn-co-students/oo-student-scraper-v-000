require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    index_url.css(".student-card").map do |profile|
      {name: profile.css("h4.student-name").text,
      location: profile.css("p.student-location").text,
      profile_url: profile.css("a")[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)

    profile_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = doc.css("div .social-icon-container").children.css("a").map do |profile|
      #binding.pry
      profile.attribute("href").value
        student.each do |link|
          if link.include? ("twitter")

    end
  end
end
