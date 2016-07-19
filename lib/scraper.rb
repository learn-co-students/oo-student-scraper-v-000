require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)
	    
	    doc = Nokogiri::HTML(open(index_url))
	    all_students_array = []
	    doc.css("div.student-card").each {|student|
	    	each_student_hash = {name: student.css("h4").text,
			location: student.css("p").text,
	    	profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").value}", 
	    	}
	    	all_students_array << each_student_hash
	    }
	    all_students_array
    end

    def self.scrape_profile_page(profile_url)
	   
	    profile = Nokogiri::HTML(open(profile_url))
	    #binding.pry
	    student_hash = {}
	    profile.css("div.social-icon-container a").select {|social_site| link = social_site.attribute("href").value

	    	case

			when link.include?("twitter")
				student_hash[:twitter] = link
			when link.include?("linkedin")
				student_hash[:linkedin] = link
			when link.include?("github")
				student_hash[:github] = link
			when social_site.css("img.social-icon").attribute("src").value.include?("rss")
				student_hash[:blog] = link
			end
		}

		student_hash[:profile_quote] = profile.css("div.profile-quote").text
		student_hash[:bio] = profile.css("p").text
		student_hash
	end
end


#Scraper.scrape_index_page("fixtures/student-site/index.html")
#Scraper.scrape_profile_page("fixtures/student-site/students/adam-fraser.html")
#Scraper.scrape_profile_page("fixtures/student-site/students/danny-dawson.html")



