require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css(".student-card").each do |student|
      hash = {}
      path_to = "http://students.learn.co/"
      student_profile = student.children[1].attr("href")
      hash[:name] = student.children.css(".student-name").text
      hash[:location] = student.children.css(".student-location").text
      hash[:profile_url] = path_to << student_profile
      scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}
    profile_xml = doc.css(".profile")
    valid_social_keys = [:twitter, :linkedin, :github]
    profile_xml.children.css(".social-icon-container a").each do |node|
      url = node.attr("href")
      img_path = node.css("img").attr("src").value
      unless url == "" || url == "#"
        hostname = URI.parse(url).host
        key = hostname.gsub(/\Awww./, "").chomp(File.extname(hostname)).to_sym
      end

      scraped_profile[key] = url if valid_social_keys.include?(key)
      scraped_profile[:blog] = url if img_path.include?("rss")
    end
    scraped_profile[:profile_quote] = profile_xml.css(".profile-quote").text
    scraped_profile[:bio] = profile_xml.css(".bio-content .description-holder").text
    scraped_profile
  end

end
