require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    students_XML = index_page.css("div.roster-cards-container div.student-card")

    students_XML.each do |student|
      students << {
        name: student.css("a div.card-text-container h4.student-name").text,
        location: student.css("a div.card-text-container p.student-location").text,
        profile_url: "./fixtures/student-site/#{student.css("a").attr('href').value}"
      }
    end
    students
    # binding.pry
   end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    links_XML = profile_page.css("div.social-icon-container a")

    profile = {}
      links_XML.map do |a|
        if a.attr("href").include? "twitter.com"
          profile[:twitter] = a.attr("href")
        elsif a.attr("href").include? "linkedin.com"
          profile[:linkedin] = a.attr("href")
        elsif a.attr("href").include? "github.com"
          profile[:github] = a.attr("href")
        else
          profile[:blog] = a.attr("href")
        end
      end

      profile[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text

      profile[:bio] = profile_page.css("div.bio-content div.description-holder p").text

      profile

    # twitter: links_ML.select{|a| a.attr("href").include? "twitter.com"}[0].attr("href")

    # linkedin: links_XML.select{|a| a.attr("href").include? "linkedin.com"}[0].attr("href")

    # github: links_XML.select{|a| a.attr("href").include? "github.com"}[0].attr("href")

    # blog:

    # profile_quote: profile_page.css("div.vitals-text-container div.profile-quote").text

    # bio: profile_page.css("div.bio-content div.description-holder p").text

    # binding.pry
  end

end

# students = Scraper.scrape_index_page("./fixtures/student-site/index.html")
# puts students[0]

# Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
