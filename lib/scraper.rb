require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read("./fixtures/student-site/index.html")
    scraper = Nokogiri::HTML(html)

    students = []

    scraper.css("div.roster-body-wrapper").each do |home|
      home.css("div.roster-cards-container").each_with_index do |profile, index|
        binding.pry
        students << {:name => profile.css("h4.student-name")[index].children.text,
          :location => profile.css("p.student-location")[index].children.text,
          :profile_url => profile.children.css("a").attr("href").value
        }
    end
  end
  students
end

  def self.scrape_profile_page(profile_url)

  end

end
