require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))

    students = []
    # Iterate through students
    index.css("div.roster-body-wrapper").each do |card|
      card.css("div.student-card").each do |student|
        students << {
          :name => student.css("h4.student-name").text,
          :location => student.css("p.student-location").text,
          :profile_url => "http://127.0.0.1:4000/#{ student.css("a").attribute("href").text}"
        }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    profile.css("div.social-icon-container a").select{|link| link['href']}.each do |link|
      student[:github] = link['href'] if /github/.match(link['href'])
      student[:twitter] = link['href'] if /twitter/.match(link['href'])
      student[:linkedin] = link['href'] if /linkedin/.match(link['href'])
      student[:blog] = link['href'] if !/(github|linkedin|twitter)/.match(link['href'])
    end
    student[:bio] = profile.css("div.description-holder p").text
    student[:profile_quote] = profile.css("div.profile-quote").text
    student
  end

end
