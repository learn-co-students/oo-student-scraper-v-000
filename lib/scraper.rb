require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

     roster =[]
     page = open(index_url)
     doc = Nokogiri::HTML(page)
     students = doc.css(".student-card")

    students.each do |student|
      roster << {:name => student.at(".student-name").text,
        :location => location = student.at(".student-location").text,
        :profile_url => profile_url = student.at("a").attributes['href'].value}
      end
    roster

  end

  def self.scrape_profile_page(profile_url)

    links = {}
    page=Nokogiri::HTML(open(profile_url))
    all_links = page.css(".social-icon-container a").map {|single| single.attr('href')}
    all_links.each do |link|
          case
          when link.include?("twitter")
            links[:twitter] = link
          when link.include?("linkedin")
            links[:linkedin] = link
          when link.include?("github")
            links[:github] = link
          else
            links[:blog] = link
        end
      end
      links[:profile_quote] = page.css(".vitals-text-container .profile-quote").text
      links[:bio] = page.css(".description-holder p").text
      links
    end

 end
