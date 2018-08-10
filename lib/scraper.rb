require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read("./fixtures/student-site/index.html")
    scraper = Nokogiri::HTML(open(index_url))

    students = []

    scraper.css("div.roster-body-wrapper").each do |home|
      home.css("div.student-card").each_with_index do |profile, index|
       students << {:name => profile.css("h4.student-name").text,
          :location => profile.css("p.student-location").text,
          :profile_url => profile.css("a").attr("href").value
        }
    end
  end
  students
end

  def self.scrape_profile_page(profile_url)
    scraper = Nokogiri::HTML(open(profile_url))
    student = {}
    links = scraper.css(".social-icon-container a").map{|l| l.attributes["href"].value}
    links.each do |link|
          if link.include?("linkedin")
            student[:linkedin] = link
          elsif link.include?("twitter")
            student[:twitter] = link
          elsif link.include?("github")
            student[:github] = link
          elsif link.include?("youtube")
            student[:youtube] = link
          else
            student[:blog] = link
          end
        end
        student[:profile_quote] = scraper.css("div.profile-quote")[0].text
        student[:bio] = scraper.css("div.description-holder")[0].children.text.strip
        student
      end





end
