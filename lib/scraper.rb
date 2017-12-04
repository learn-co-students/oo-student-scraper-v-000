require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container").each do |roster|
      roster.css(".student-card").each do |student|
        st_name = student.css("h4").text
        st_location = student.css("p").text
        st_profile_url = student.at('a')['href']#{}"./fixtures/student-site/#{student.attr('href')}"
        students << {:name=>st_name, :location=>st_location, :profile_url=>st_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profiles = {}
    profile = Nokogiri::HTML(open(profile_url))
    profile.css(".social-icon-container").each do |p|
      links = p.css('a').map {|element| element["href"]}.compact
      links.each do |link|
        if link.include?("twitter")
          profiles[:twitter] = link
        elsif link.include?("linkedin")
          profiles[:linkedin] = link
        elsif link.include?("github")
          profiles[:github] = link
        else
          profiles[:blog] = link
        end
        #binding.pry
      end

    end
    profiles[:profile_quote] = profile.css('.profile-quote').text if profile.css('.profile-quote').text
    profiles[:bio]   = profile.css('.description-holder p').text if profile.css('.description-holder p').text
    profiles

  end

end
