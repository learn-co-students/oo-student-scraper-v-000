require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students_array = []

    names = doc.css("h4.student-name").map(&:text)
    locations = doc.css("p.student-location").map(&:text)

    names.each do |n|
        h = {}
        h[:name] = n

        slug_name = n.downcase.gsub(/\s/, '-')
        h[:profile_url] = "./fixtures/student-site/students/" + slug_name + ".html"
        students_array << h
    end

    i = 0;
    students_array.each do |h|
      i+=1
      h[:location] = locations[i]
    end

    return students_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    element = doc.css("div.social-icon-container a")
    i = 0

    while i < 5
      if element[i]
        if element[i].attributes["href"].value.include?("twitter")
          twitter = doc.css("div.social-icon-container a")[i].attributes["href"].value
          student[:twitter] = twitter

        elsif element[i].attributes["href"].value.include?("linkedin")
          linkedin = doc.css("div.social-icon-container a")[i].attributes["href"].value
          student[:linkedin] = linkedin

        elsif element[i].attributes["href"].value.include?("github")
          github = doc.css("div.social-icon-container a")[i].attributes["href"].value
          student[:github] = github

        else
          blog = doc.css("div.social-icon-container a")[i].attributes["href"].value
          student[:blog] = blog
        end
      end
    i+=1
  end

    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text

    student
  end

end
