require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card").css("a")
#    binding.pry
    #test2 = students[0]["href"]
    #test3 = students[0].children
    #name = students[0].children.css(".student-name").text
    #location = students[0].children.css(".student-location").text
    students.to_ary.each { |student|
      student_hash = {}
      student_hash[:name] = student.children.css(".student-name").text
      student_hash[:location] = student.children.css(".student-location").text
      student_hash[:profile_url] = student["href"]
      student_info << student_hash
    }
    student_info
  end

  def self.scrape_profile_page(profile_url)
    profile_links = []
    links_hash = {}
    page = Nokogiri::HTML(open(profile_url))
    links = page.css(".social-icon-container").css("a")
    profile_quote = page.css(".profile-quote").text
    if profile_quote != ""
      links_hash[:profile_quote] = profile_quote
    end
    biography = page.css(".description-holder p").children.text
    if biography != ""
      links_hash[:bio] = biography
    end
    link2 = links[0]["href"]
    for link in 0..links.size - 1
      profile_links << links[link]["href"]
    end
    profile_links.each { |link|
      if /twitter/.match(link)
        links_hash[:twitter] = link
      elsif /linkedin/.match(link)
        links_hash[:linkedin] = link
      elsif /github/.match(link)
        links_hash[:github] = link
      else
        links_hash[:blog] = link
      end
    }
#    binding.pry
    links_hash
  end

end

#test = Scraper.scrape_index_page("./fixtures/student-site/index.html")
test = Scraper.scrape_index_page("http://67.205.146.216:30004/fixtures/student-site/index.html")
#binding.pry
Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
