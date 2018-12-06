require "open-uri"

class Scraper
  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card a").each do |student|
      profile_url = student.attr("href")
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      students << { :name => name, :location => location, :profile_url => profile_url }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |social|
      link = social.attr("href")
      if link.include?("facebook")
        profile[:facebook] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".bio-content p").text
    profile
  end
end