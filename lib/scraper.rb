require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :student
  @@all = []

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    #studnets = page.css("div.student-card")
    # iterate through students to find
    #page.css("div.student-card").first =>Ryans card
    # page.css("div.card-text-container h4").first.text => Ryan's name
    #page.css("div.card-text-container p").first.text => Ryan's location
    #page.css("div.student-card a").first.attribute("href").value

    # binding.pry
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|

        student_href = "#{student.attr("href")}"
        student_location = student.css(".student-location").text
        student_name = student.css('.student-name').text
        # binding.pry
        students << {
          :name => student_name,
          :location => student_location,
          :profile_url => student_href
        # binding.pry
          }
      end
    end
      students
  end


  def self.scrape_profile_page(profile_url)
     page = Nokogiri::HTML(open(profile_url))

     student_page = {}

     social_links = page.css(".social-icon-container").css('a').collect {|e| e.attributes["href"].value}

     social_links.detect do |e|

       student_page[:twitter] = e if e.include?("twitter")
       student_page[:linkedin] = e if e.include?("linkedin")
       student_page[:github] = e if e.include?("github")

     end

     student_page[:blog] = social_links[3] if social_links[3] != nil
     student_page[:profile_quote] = page.css(".profile-quote")[0].text
     student_page[:bio] = page.css(".description-holder").css('p')[0].text
     student_page
   end
 end

  # def self.scrape_profile_page(profile_url)
  #   profile_page = Nokogiri::HTML(open(profile_url))
  #   student = {}
  #   # binding.pry
  #   links = profile_page.css(".social-icon-container").children.css("a").collect { |e| e.attributes["href"].value}
  #   # links.detect do |link|
  #   # binding.pry
  #
  #     student[:twitter] = links[0]
  #     student[:linkedin] = links[1]
  #     student[:github] = links[2]
  #     student[:blog] = links[3]
  #     student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  #     student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p")
  #     binding.pry
  #
  #
  #
  #
  #
  #
  #   # student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  #   # student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p")
  #   student
  #   # binding.pry
  #   # student << {
  #   #   student[:twitter]
  #   #   student[:linkedin
  #   #   student[:github]
  #   #   student[:blog]
  #   #   student[:profile_quote]
  #   #   student[:bio]
  #   # }
  #   # end
  #
  # end
  #
  # end
# end
