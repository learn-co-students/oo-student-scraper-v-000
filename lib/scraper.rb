require 'open-uri'
require 'nokogiri'
require 'pry'
class Scraper
   attr_accessor :student_hash_array, :student_hash

  def self.scrape_index_page(index_url)

    html = open(index_url)
  doc = Nokogiri::HTML(html)
  array = []
  doc.css("div.roster-cards-container").each{|cards|
    cards.css('.student-card').each { |student|
      students = {}
    students[:name] = student.css(".student-name").text
    students[:location] = student.css(".student-location").text
    students[:profile_url] = './fixtures/student-site/' + student.css("a").attribute("href").value
    array << students
  }
}
     array
    end

  def self.scrape_profile_page(profile_url)
      #puts profile_url
    doc = Nokogiri::HTML(open(profile_url))

    profile_hash = {}
    #binding.pry
    doc.css(".social-icon-container a").each do |social| #.children.css("a")[0].attr('href').value
      url = social.attributes['href'].value
      profile_hash[:twitter] = url if url.include?('twitter')
      profile_hash[:linkedin] = url if url.include?('linkedin')
      profile_hash[:github] = url if url.include?('github')
      profile_hash[:blog] = url if !url.include?('twitter') && !url.include?('linkedin') && !url.include?('github')
    end

    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder").css("p").text
    #binding.pry
     profile_hash
  end

end
