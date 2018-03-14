require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_pages = Nokogiri::HTML(html)

    scraped_students = []

    index_pages.css('div.student-card').each do |index_page|
      attribute = {
        :name => index_page.css('a div.card-text-container h4').text,
        :location => index_page.css('a div.card-text-container p').text,
        :profile_url => index_page.css('a').attribute("href").value
      }
      scraped_students << attribute
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = File.open(profile_url) {|f| Nokogiri::HTML(f) }

    student = {}

    links = doc.css(".social-icon-container").children.css("a").map {|el| el.attribute("href").value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end

    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end
