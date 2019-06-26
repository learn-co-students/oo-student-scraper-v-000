require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #esponsible for scraping the index page that lists all of the students
    array = []
    doc =  Nokogiri::HTML(open(index_url))
#    binding.pry
    doc.css("div.student-card").each do |card|
    array << {name: card.css("h4.student-name").text,
              location: card.css("p.student-location").text,
              profile_url: card.css("a").attribute("href").value
              }
    end
    array
#     binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #responsible for scraping an individual student's profile page to get further information about that student.
    doc = Nokogiri::HTML(open(profile_url))
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
      doc.css("div.social-icon-container a").each do |icon|
        icon.each do |a|
          twitter = a[1] if a[1].include?("twitter")
          linkedin = a[1] if a[1].include?("linkedin")
          github = a[1] if a[1].include?("github")
          blog_name = "http:\/\/" + doc.css("h1.profile-name").text.split[0][0].downcase
          blog = a[1] if a[1].include?(blog_name)
        end
      end
#binding.pry
if   twitter == "" && blog == ""
  hash = {linkedin: linkedin,
          github: github,
          profile_quote: doc.css("div.profile-quote").text,
          bio: doc.css("div.description-holder p").text
      }
  else
    hash = {twitter: twitter,
        linkedin: linkedin,
        github: github,
        blog: blog,
        profile_quote: doc.css("div.profile-quote").text,
        bio: doc.css("div.description-holder p").text
        }
      end
    end


end
