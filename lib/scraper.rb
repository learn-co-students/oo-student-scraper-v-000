require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.open(index_url))
    students = Array.new

    doc.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(File.open(profile_url))

    urls = doc.css("div.social-icon-container a")

    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("p").text

    urls.each do |url|
      case address = url.attribute("href").value
      when /twitter/ then twitter = address
      when /linkedin/ then linkedin = address
      when /github/ then github = address
      else blog = address
      end
    end

    profile = {
      twitter: twitter,
      linkedin: linkedin,
      github: github,
      blog: blog,
      profile_quote: profile_quote,
      bio: bio
    }.delete_if { |key, value| value.empty? }

  end
end
