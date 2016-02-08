require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students= doc.css(".student-card")
   	
    students= students.collect do |student| 
    	{ name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "http://127.0.0.1:4000/#{student.css("a").first["href"]}"
      	} 
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  	html = open(profile_url)
    student_profile = Nokogiri::HTML(html)
   

	student_profile_attr= {}
		student_profile.css("a").each do |link|
			
			if link['href'].scan(/twitter/).join == "twitter"
				student_profile_attr[:twitter] = link['href']
			elsif link['href'].scan(/linkedin/).join == "linkedin"
	    		student_profile_attr[:linkedin] = link['href']
	    	elsif link['href'].scan(/github/).join == "github"
	    		student_profile_attr[:github] = link['href']
	    	elsif link['href'].size > 5
	    		student_profile_attr[:blog] = link['href']
	    	end
		end

	    student_profile_attr[:profile_quote]= student_profile.css(".profile-quote").text
	

	    student_profile_attr[:bio]= student_profile.css(".description-holder p").text

	student_profile_attr
    
  end

end

