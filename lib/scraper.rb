require "rubygems"
require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)
      html = File.read(index_url)
      student_profile = Nokogiri::HTML(html)
      scraped_students = [ ]
      #iterate through the studentsS
      student_profile.css("div.student-card").each do |student| #iterate through each student card
      scraped_students << { :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
          }
      end
    scraped_students # return scraped students array
  end # end of method

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_profile = Nokogiri::HTML(html)
       scraped_student = { } # set up empty hash

            link = student_profile.css("div.social-icon-container a") #shortcut to social-icon-container which contains the anchor tags
               link.each do |a| # iterate over each anchor tag in the social-icon-container
                      url_string = a["href"].to_s
                if  url_string.include? "twitter" # if social url includes twitter
                     scraped_student[:twitter] = url_string # set hash value as href text  for twitter anchor tag
                elsif url_string.include? "linkedin"
                   scraped_student[:linkedin] = url_string
                 elsif url_string.include? "github"
                    scraped_student [:github] = url_string
                 else
                   scraped_student[:blog] = url_string
                 end #end of if-else block
                 scraped_student [:profile_quote] = student_profile.css("div.profile-quote").text if student_profile.css("div.profile-quote").text
                 scraped_student [:bio] = student_profile.css("div.description-holder p").text if student_profile.css("div.description-holder p").text

              end # end of enumerator block

            scraped_student

      end # end of method

end # end of class
