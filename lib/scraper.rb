require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students=[]
    doc= Nokogiri::HTML(open(index_url))
   card=doc.css (".student-card a")
   card.each do |student|
      s_name=student.css('.student-name').text
      s_location=student.css('.student-location').text
      s_profile="#{student.attr('href')}"
      students << {name: s_name, location: s_location, profile_url: s_profile}
      #binding.pry
    end
    students

  end

  def self.scrape_profile_page (profile_url)
    student={}
    #twitter url, linkedin url, github url, blog url, profile quote, and bio
    doc= Nokogiri::HTML(open(profile_url))

    links = doc.css(".social-icon-container").css("a").map { |el| el.attr('href')}
    links.each do |link|
    if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote]=doc.css(".profile-quote").text
    student[:bio]=doc.css("div.bio-content.content-holder div.description-holder p").text
    #profile_page.css("div.bio-content.content-holder div.description-holder p").text
    #binding.pry
    student
  end
end



    #doc.css('.social-icon-container').each do |x|
      #x.css("a").map do |y|

        #{}"#{y.attr("href")}"



      #x.first.css("a")

    #.each do |x|
      #twitter= "#{x.attr('a')}"

      #x.each {|y|"#{x.attr('a')}"}


      #link="#{x.attr('a')}"
    #links=doc.css('.social-icon-container a')
    #binding.pry
    #links.each do |x|

    #end

    #binding.pry
    #twitter_link="#{links.attr('href')}"
    #{}"#{doc.attr('href')}"
    #binding.pry
