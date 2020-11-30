require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
   
    doc.css(".student-card").each do |student|
      s = {
        :name => student.css("h4").text, :location => student.css('p').text, :profile_url => student.css('a').attribute("href").value
        }
      students << s
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    
    student[:profile_quote] = profile.css(".profile-quote").text 
    student[:bio] = profile.css("p").text
    
    profile.css('div.social-icon-container a').map do |link|
      if link.values.to_s.include?('twitter')
        student[:twitter] = link['href']
      elsif link.values.to_s.include?('linkedin')
        student[:linkedin] = link['href']
      elsif link.values.to_s.include?('github')
        student[:github] = link['href']
      elsif link.values.to_s.include?('.com')
        student[:blog] = link['href']
      end
    end
    student
    # binding.pry
  end
end
    


