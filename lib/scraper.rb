require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    page = Nokogiri::HTML(open(index_url))
    students = []
    counter = 0

    page.css(".roster-cards-container").each do |roster_card|
        roster_card.css(".student-card").each do |student|
          students[counter] = {
            :name => student.css("h4.student-name").text,
            :location => student.css("p.student-location").text,
            :profile_url => ("./fixtures/student-site/") + student.css("a").attr('href').text
          }
          counter += 1
        end
    end

    students

    #binding.pry

  end

  def self.scrape_profile_page(profile_url)

    page = Nokogiri::HTML(open(profile_url))
    student_hash = Hash.new
    student_symbol = page.css(".profile-name").text.to_sym

    social_block = page.css(".social-icon-container")
    social_block.css("a").each do |link|
      social_link = link.attr('href')
      if (social_link =~ /twitter(.*)/)
        student_hash[:twitter] = social_link
      elsif (social_link =~ /linkedin(.*)/)
        student_hash[:linkedin] = social_link
      elsif (social_link =~ /github(.*)/)
        student_hash[:github] = social_link
      else
        student_hash[:blog] = social_link
      end
      #binding.pry
    end

    student_hash[:profile_quote] = page.css(".profile-quote").text
    student_hash[:bio] = page.css(".bio-content .description-holder p").text
    # student_hash[student_symbol] = {
    #   :profile_quote => page.css(".profile-quote").text,
    #   :bio => page.css(".bio-content .description-holder p").text
    # }
    #binding.pry
    student_hash
  end

end
