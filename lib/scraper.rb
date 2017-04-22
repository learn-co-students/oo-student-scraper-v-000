require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")

    students.map do |student|
      {:name => "#{student.css(".student-name").text}", :location => "#{student.css(".student-location").text}", :profile_url => "./fixtures/student-site/#{student.css("a").first.attr('href')}"}
    end
    
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    social_media_links = doc.css("a").map {|element| element["href"]}
    host_components = social_media_links.map { |u| URI(u).host }
    twitter = social_media_links[host_components.index("twitter.com")]
    linkedin = social_media_links[host_components.index("www.linkedin.com")]
    github = social_media_links[host_components.index("github.com")]
    blog_base_url = host_components.reject {|e| e == "twitter.com" || e == "www.linkedin.com" || e == "github.com" || e == nil}.first
    blog_full_url = social_media_links[host_components.index(blog_base_url)]
    profile_quote = doc.css(".vitals-text-container .profile-quote").text
    bio = doc.css(".details-container p").text

    puts ":twitter=>#{twitter}"
    puts ":linkedin=>#{linkedin}"
    puts ":github=>#{github}"
    puts ":blog=>#{blog_full_url}"
    puts ":profile_quote=> #{profile_quote}"
    puts ":bio => #{bio}"

    profile_page = {:twitter=>"#{twitter}",
    :linkedin=>"#{linkedin}",
    :github=>"#{github}",
    :blog=>"#{blog_full_url}",
    :profile_quote=> "#{profile_quote}",
    :bio => "#{bio}"
    }
    profile_page
  end

end

