require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").collect do |student|
      {:name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/" + student.css("a").attribute("href").value}
      end

    end

    def self.scrape_profile_page(profile_url)
      student = Nokogiri::HTML(open(profile_url))
      #binding.pry
      profile = {}
      # social attributes (twitter, github, linkedin) are in a nested array and must be called on by index
      social = student.css("div.main-wrapper div.social-icon-container a")
      if social.size == 4
        student.css("div.main-wrapper").each do |s|
          social = s.css("div.social-icon-container a")
          profile = { :twitter => social[0].attribute("href").value,
            :linkedin => social[1].attribute("href").value,
            :github => social[2].attribute("href").value,
            :blog => social[3].attribute("href").value,
            :profile_quote => s.css("div.profile-quote").text,
            :bio => s.css("div.details-container p").text}
          end
        else
          counter = 0
          social.size.times do
            if social[counter].attribute("href").value.include?("twitter")
              profile[:twitter] = social[counter].attribute("href").value
            elsif social[counter].attribute("href").value.include?("linkedin")
              profile[:linkedin] = social[counter].attribute("href").value
            elsif social[counter].attribute("href").value.include?("github")
              profile[:github] = social[counter].attribute("href").value
            elsif social[counter].attribute("href").value.include?("blog")
              profile[:blog] = social[counter].attribute("href").value
            end
            counter += 1
          end
          profile[:profile_quote] = student.css("div.profile-quote").text
          profile[:bio] = student.css("div.details-container p").text
        end
        profile
      end

    end

    #scrape_profile_page
    #student.css("div.main-wrapper").collect{|s| s.css("div.vitals-container div.social-icon-container a").attribute("href").value}
    #social icons: s.css("div.social-icon-container")
    # :twitter => s.css("div.social-icon-container a")[0].attribute("href").value
    # :linkedin => s.css("div.social-icon-container a")[1].attribute("href").value
    # :github => s.css("div.social-icon-container a")[2].attribute("href").value
    # :blog => s.css("div.social-icon-container a")[3].attribute("href").value
    # :profile_quote => s.css("div.profile-quote").text
    # :bio => s.css("div.details-container p").text

    # scrape_index_page
    #students: doc.css("div.student-card")
    # name link: student.css("h4.student-name").text
    # location: student.css("p.student-location").text
    # profile_url: student.css("a").attribute("href").value
