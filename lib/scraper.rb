require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
     doc.css('.student-card').collect do |student|
      {:name => student.css('h4').text, :location => student.css('p').text, :profile_url => student.css('a')[0]['href']}
    end
  end

  def self.scrape_profile_page(profile_url)
    student = {}

    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_node = doc.css('.social-icon-container a')

    student[:bio] = doc.css('p').text
    student[:profile_quote] = doc.css(".profile-quote").text

    social_node.each do |element|
      if element['href'].include?("twitter")
        student[:twitter] = element['href']
      elsif element['href'].include?("linkedin")
        student[:linkedin] = element['href']
      elsif element['href'].include?("github")
        student[:github] = element['href']
      else
        student[:blog] = element['href']
      end
    end

      student
    # student[:twitter]= social_node[0]['href']
    # student[:linkedin]=social_node[1]['href']
    # student[:github]=social_node[2]['href']
    # student[:blog]= social_node[3]['href']
    # student

  end

end
