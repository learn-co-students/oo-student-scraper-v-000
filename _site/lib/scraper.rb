require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    localhost = "http://127.0.0.1:4000/"

    student = index_page.css(".student-card a").map do |student_info|
      {
        name: student_info.css(".student-name").text,
        location: student_info.css(".student-location").text,
        profile_url: localhost + student_info.attr('href')
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    profile_links = profile_page.css(".social-icon-container a").each do |a|
      if a['href'].include?("twitter.com")
        student[:twitter] = a['href']
      elsif a['href'].include?("linkedin.com")
        student[:linkedin] = a['href']
      elsif a['href'].include?("github.com")
        student[:github] = a['href']
      else
        student[:blog] = a['href']
      end
    end

    profile_quote = profile_page.css(".profile-quote").text.strip
    unless profile_quote.nil? || profile_quote.empty?
      student[:profile_quote] = profile_quote
    end

    bio = profile_page.css(".description-holder p").text.strip
    unless bio.nil? || bio.empty?
      student[:bio] = bio
    end
    student
  end

end
