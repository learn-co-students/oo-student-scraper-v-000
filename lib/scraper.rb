require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css("div.student-card").each do |card|
      s = {
        :name => card.css('h4.student-name').text,
        :location => card.css('p.student-location').text,
        :profile_url => card.css('a').attribute('href').value}
      students << s
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    prof_hash = {}

    profile_info = doc.css(".vitals-container .social-icon-container a").collect do |links|
      links.attribute("href").value
    end

    profile_info.each do |l|
      if l.include?("twitter")
        prof_hash[:twitter] = l
      elsif l.include?("linkedin")
        prof_hash[:linkedin] = l
      elsif l.include?("github")
        prof_hash[:github] = l
      else l.include?("blog")
        prof_hash[:blog] = l
      end
    end
    prof_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    prof_hash[:bio] = doc.css(".description-holder p").text
    prof_hash
  end

end
