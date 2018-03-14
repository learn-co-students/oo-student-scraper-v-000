require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper  

  def self.scrape_index_page(index_url)
    #html = File.read("fixtures/student-site/index.html")
    #page = Nokogiri::HTML(html)
    html = index_url
    page = Nokogiri::HTML(open(html))

    students = []

    page.css('.roster-cards-container .student-card').each do |student|
      students << {
        :name => student.css('.card-text-container .student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => "./fixtures/student-site/#{student.css('a').attr('href')}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = profile_url
    page = Nokogiri::HTML(open(html))

    profile = {}

    social = page.css('.vitals-container')
    base = social.css('.social-icon-container a').map { |l| l.attr('href') }

    base.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end  
    end
    
    profile[:profile_quote] = social.css('.vitals-text-container .profile-quote').text
    profile[:bio] = page.css(".bio-block .description-holder p").text
    
    profile
  end

end

# Scraper.scrape_profile_page("./fixtures/student-site/students/jenny-yamada.html")


