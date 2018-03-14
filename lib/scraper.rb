require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :index_url
  BASE_PATH = "./fixtures/student-site/"

  def self.get_page(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
  end

  def self.get_cards
    self.get_page(@index_url).css(".student-card")
  end

  def self.scrape_index_page(index_url)
    @index_url = index_url
    student_arr = []
    self.get_cards.each do |card|
      hash = {}
      hash[:name] = card.css("a .card-text-container .student-name").text
      hash[:location] = card.css("a .card-text-container .student-location").text
      hash[:profile_url] = BASE_PATH + card.css("a").first.attr('href')
      student_arr << hash
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    socials = {:twitter=>"twitter",:linkedin=>"linkedin",:github=>"github",:blog=>"rss"}
    link_img={}; profile = {}

    page = self.get_page(profile_url)

    links = page.css(".social-icon-container a").map{ |link| link['href']}
    imgs = page.css(".social-icon-container a img").map{ |img| img['src']}

    links.each_with_index { |link,i| link_img[link]=imgs[i]}

    link_img.each do |link,img|
       socials.each { |social,subs| profile[social] = link if img.include?(subs)}
    end
    profile[:profile_quote] = page.css(".profile-quote").text
    profile[:bio] = page.css(".bio-content .description-holder p").text
    profile
  end

end
