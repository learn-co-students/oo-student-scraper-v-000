require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	#empty = {:name => "NAME", :location => "NYC", :url => "./fixtures/student-site/stundents/Abby-Smith.html"}
    scraped_students = []
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

	    #index_page.css('.student-card').each do |student|
	    #	student_name = student.css('h4.student-name').text
	    #	empty[student_name.to_sym] = {
	    #		:location => student.css('p.student-location').text,
	    #		:url => student.css('a').attribute('href').value
	    #	}
	    #end
	    index_page.css('.student-card').each do |student|

	    	scraped_students << {
	    		:name => student.css('h4.student-name').text,
	    		:location => student.css('p.student-location').text,
	    		:profile_url => student.css('a').attribute('href').value
	    	}
	    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  		html = open(profile_url)
    	doc = Nokogiri::HTML(html)

  		st_name = doc.css('h1.profile-name').text
  		st_name.to_sym
  		scraped_student = {}#{st_name => {}}

    	#twitter, url, linkedIn url, github url, blog url, profile quote, bio
    	doc.css('.social-icon-container').children.css('a').each do |inside|

    			if inside.attribute('href').value.include?("twitter")
		    		scraped_student[:twitter] = inside.attribute('href').value
		    	elsif inside.attribute('href').value.include?("linkedin")
		    		scraped_student[:linkedin] = inside.attribute('href').value
		    	elsif inside.attribute('href').value.include?("github")
		    		scraped_student[:github] = inside.attribute('href').value
		    	else
		    		scraped_student[:blog] = inside.attribute('href').value
		    	end
    	end
    	#profile_quote
    	pq = doc.css('.vitals-text-container .profile-quote').text
    	scraped_student[:profile_quote] = pq
    	#bio
    	bio = doc.css('.description-holder p').text
    	scraped_student[:bio] = bio

    	return scraped_student
  end

end
