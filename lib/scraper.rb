require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    [].tap do |student_array|
      index_page.css(".student-card").each do |student|
        student_profile = {}
        student_profile[:name] = student.css("h4.student-name").text
        student_profile[:location] = student.css("p.student-location").text
        student_profile[:profile_url] = "./fixtures/student-site/#{student.css("a").attribute("href").value}"
        student_array << student_profile
      end
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    {}.tap do |profile_detail|
      profile_page.css(".social-icon-container a[href*=\"twitter\"]").empty? ? profile_detail[:twitter] = "" : profile_detail[:twitter] = profile_page.css(".social-icon-container a[href*=\"twitter\"]").attribute("href").value
      profile_page.css(".social-icon-container a[href*=\"github\"]").empty? ? profile_detail[:github] = "" : profile_detail[:github] = profile_page.css(".social-icon-container a[href*=\"github\"]").attribute("href").value
      profile_page.css(".social-icon-container a[href*=\"linkedin\"]").empty? ? profile_detail[:linkedin] = "" : profile_detail[:linkedin] = profile_page.css(".social-icon-container a[href*=\"linkedin\"]").attribute("href").value
      profile_page.css(".social-icon-container a img[src*=\"rss\"]").empty? ? profile_detail[:blog] = "" : profile_detail[:blog] = profile_page.css(".social-icon-container a img[src*=\"rss\"]").first.parent.attribute("href").value
      profile_page.css(".profile-quote").empty? ? profile_detail[:profile_quote] = "" : profile_detail[:profile_quote] =  profile_page.css(".profile-quote").text
      profile_page.css(".bio-content .description-holder p").empty? ? profile_detail[:bio] = "" : profile_detail[:bio] = profile_page.css(".bio-content .description-holder p").text
      profile_detail.delete_if { |key,value| value == ""  }
    end
  end
end
