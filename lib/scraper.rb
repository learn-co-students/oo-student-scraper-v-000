require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url)).css(".roster-cards-container .student-card")
    students.map do |student|
      {name: student.css("h4.student-name").text, location: student.css("p.student-location").text, profile_url: student.css("a")[0]["href"]}
    end
  end

  def self.scrape_profile_page(profile_url)
    Hash.new.tap do |profile|
      social = Nokogiri::HTML(open(profile_url)).css(".social-icon-container a")
      social.map do |link|
        icon = link.css(".social-icon").attribute("src").value
        if icon.include? "twitter"
          key = :twitter
        elsif icon.include? "linkedin"
          key = :linkedin
        elsif icon.include? "github"
          key = :github
        elsif icon.include? "rss"
          key = :blog
        else
          key = :etc
        end
        profile.store(key, link.attribute("href").value)
      end
      profile[:profile_quote] = Nokogiri::HTML(open(profile_url)).css(".profile-quote").text
      profile[:bio] = Nokogiri::HTML(open(profile_url)).css(".bio-content p").text
    end
  end

end