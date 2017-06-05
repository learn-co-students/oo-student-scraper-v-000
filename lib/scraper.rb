require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    student_page = Nokogiri::HTML(html)
  
    students = []
    index = 0

    student_page.css("div.student-card").each{ |student|
      students[index] = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text, 
        :profile_url => student_page.css("div.student-card a")[index]['href'] #
      }
      index += 1
    }

  students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    profile_data = {}
    hrefs = profile_page.css("div.social-icon-container a").map {|link| link.attribute('href').to_s}#
    
    twitter = hrefs.detect{|index| index.include?("twitter")}
    profile_data[:twitter] = twitter if twitter

    linkedin = hrefs.detect{|index| index.include?("linkedin")}
    profile_data[:linkedin] = linkedin if linkedin

    github = hrefs.detect{|index| index.include?("github")}
    profile_data[:github] = github if github

    #assuming blogs have .com or .com/ at very end of string
    blog = hrefs.detect{|index| /(\.com\/\z)|(\.com\z)/ === index}

    profile_data[:blog] = blog if blog

    profile_data[:profile_quote] = profile_page.css("div.profile-quote").text

    profile_data[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text

  profile_data
  end

end





