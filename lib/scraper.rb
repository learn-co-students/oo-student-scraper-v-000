require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))

    students = []
    index.css(".student-card").each do |card|
      name = card.css("h4.student-name").text
      location = card.css("p.student-location").text
      student_url = "".concat(index_url).concat(card.css("a").attr("href").value)
      students.push({:name=>name, :location=>location, :profile_url=>student_url})
    end

    return students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    student = {}
    if  profile.css("a[href*='twitter']").first
      student[:twitter] =  profile.css("a[href*='twitter']").first.attr("href")
    end
    if profile.css("a[href*='linkedin']").first
      student[:linkedin] =  profile.css("a[href*='linkedin']").first.attr("href")
    end
    if  profile.css("a[href*='github']").first
      student[:github] =  profile.css("a[href*='github']").first.attr("href")
    end
    student[:profile_quote] =  profile.css(".profile-quote").text
    student[:bio] =  profile.css("div.description-holder p").text
    #student[:profile_url] = profile_url
    #student[:location] =  profile.css(".profile-location").text

    #this is so goofy
    #out of an array of social icons, find which one (if any) has "rss" in the
    #'src' attribute of the image and access an array of URLs using the index
    #at which the "rss" image was found.
    #That's just silly
    indeces = profile.css(".social-icon").map{|i| i.attr("src").include?("rss")}
    blog_index = indeces.rindex(true)
    if (blog_index!=nil)
      student[:blog] = profile.css("div.social-icon-container a")[blog_index].attr("href")
    end

    return student
  end

end

