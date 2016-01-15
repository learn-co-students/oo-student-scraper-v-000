require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
  	doc = Nokogiri::HTML(open(index_url))
  	students = doc.css("div.student-card")

  	students_array = []
  	
    students.each{|student|
  		students_array.push({
  			:name => student.css("div.card-text-container h4.student-name").text,
  			:location => student.css("div.card-text-container p.student-location").text,
  			:profile_url => index_url + "/" + student.css("a").attribute("href").value
  		})
  	}

  	students_array
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    links = student.css("div.social-icon-container a")

    links.each{|link|
      student_profile[:twitter] = link.attribute("href").value if link.attribute("href").value.include?("twitter.com")
      student_profile[:linkedin] = link.attribute("href").value if link.attribute("href").value.include?("linkedin.com")
      student_profile[:github] = link.attribute("href").value if link.attribute("href").value.include?("github.com")
      student_profile[:blog] = link.attribute("href").value if link.children.attribute("src").value == "../assets/img/rss-icon.png"

    }

    student_profile[:profile_quote] = student.css("div.profile-quote").text
    student_profile[:bio] = student.css("div.bio-content div.description-holder p").text
    student_profile
  end

end

