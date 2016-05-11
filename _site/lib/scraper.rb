require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_url = "http://brad72287-v-000-180895.nitrousapp.com:4000/fixtures/student-site/" #this is sort of cheating because nitrous isn't playing nice with default jekyll settings...
    doc = Nokogiri::HTML(open(index_url))
    #binding.pry
    doc.css('.student-card').each do |student|
      name = student.css("h4").text
      location = student.css(".student-location").text
      profile_url = student.css("a").select{|x| x}.first['href']
      students << {name: name,location: location, profile_url: "http://127.0.0.1:4000/"+profile_url}
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open("http://brad72287-v-000-180895.nitrousapp.com:4000/fixtures/student-site/"+profile_url.split("0/")[1])) #as above, I have to do this is a cheesy way because of the way nitrous interacts with jekyll
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css("div.description-holder p").text
    links = doc.css('.social-icon-container a[href]').map { |link| link['href'] }
    links.each do |link|
      hash[:twitter]= link if link.include? "twitter"
      hash[:linkedin]= link if link.include? "linkedin"
      hash[:github]= link if link.include? "github"
      hash[:blog]= link if !link.include?("twitter") && !link.include?("github") && !link.include?("linkedin")
    end
    #doc.to_s.match(/\S*twitter\S*/)
    return hash

  end

end

