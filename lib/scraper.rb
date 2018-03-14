require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)

    doc.css('.student-card').each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").first['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    page = Nokogiri::HTML(open(profile_url))

    links = page.css('.social-icon-container')

    links.css('a[href]').each do |link|
      if link.to_s.include?("twitter")
        profile[:twitter] = link['href']
      elsif link.to_s.include?("linkedin")
        profile[:linkedin] = link['href']
      elsif link.to_s.include?("github")
        profile[:github] = link['href']
      else
        profile[:blog] = link['href']
      end
    end

    # page.css(".social-icon-container").each do |link|
    #   if !link.to_s.include?("twitter") &&
    #     !link.to_s.include?("linkedin") &&
    #     !link.to_s.include?("github")
    #     profile[:blog] = link.css("a")[3]['href']
    #   end
    # end

    profile[:profile_quote] = page.css('.profile-quote').text
    profile[:bio] = page.css('.description-holder p').text

    profile
  end

end
