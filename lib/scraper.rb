require 'open-uri'
require 'pry'

# attr_accessor :linkedin, :github, :blog, :profile_quote, :bio

class Scraper

  def self.scrape_index_page(index_url)
		url = Nokogiri::HTML(open(index_url))
		url.css('.roster-body-wrapper .roster-cards-container .student-card').collect do |student|
			{
				name: student.css('a .card-text-container h4.student-name').text,
				location: student.css('a .card-text-container p.student-location').text,
				profile_url: student.css('a').attribute('href').value
			}
		end	
  end

  def self.scrape_profile_page(profile_url)
  	info = {twitter: "",linkedin: "", github: "", blog: "", profile_quote: "", bio: ""}
  	
  	url = Nokogiri::HTML(open(profile_url))
  	#collect all social links
  	links = url.css('.main-wrapper')
  	links.each do |link|
  		# binding.pry	
  		link.css('.vitals-container').search('a').each do |site|
  			# binding.pry
  			info.each do |k, v|
  				# binding.pry
  				if site.attribute('href').value.slice(k.to_s).eql?(k.to_s)
	 					info[k] = site.attribute('href').value
	 				
	 				elsif k.eql?(:blog) && info.none?{|a,b| site.attribute('href').value.slice(a.to_s).eql?(a.to_s)} && site.attribute('href').value.include?("http://")
	 				# 	# !info.values.include?(site.attribute('href').value) && !site.attribute('href').value.slice(k.to_s).eql?(k.to_s)
	 					info[k] = site.attribute('href').value
	 				end 
	 			end
	 		end

	 		link.css('.vitals-container').search('[class^="profile"]').each do |klass|
	 			# binding.pry
	 			info.each do |k,v|
	 				# binding.pry
	 				if info[k].empty? && klass.attribute('class').value.sub(/[-_]/, " ").eql?(k.to_s.sub(/[-_]/, " "))
	 					# if info[k].empty? && klass.attribute('class').value.sub(/[-_]/, " ").eql?(k.to_s.sub(/[-_]/, " "))
	 					# binding.pry
	 				 info[k] = klass.text
	 				end
	 			end
	 		end
	 		link.css('.details-container').search('[class^="bio"]').each do |klass|
	 			# binding.pry
	 			info.each do |k,v|
	 				# binding.pry
	 				if info[k].empty? && klass.attribute('class').value.slice(k.to_s).eql?(k.to_s)
	 					# binding.pry
	 				 info[k] = klass.css('p').text
	 				end
	 			end
	 		end
	 	end
	 	# binding.pry
	 	info.delete_if {|k, v| v == ""}
	end

end #. End of Class

# {:twitter=>"https://twitter.com/empireofryan", 
# 	:linkedin=>"https://www.linkedin.com/in/ryan-johnson-321629ab", 
# 	:github=>"https://github.com/empireofryan", 
# 	:blog=>"", 
# 	:profile_quote=>"", 
# 	:bio=>""
# } 






  		# keys.select do |key|
  		# 	if key.to_s == link.slice(key.to_s)

  	# if self.instance_methods.include?(link)
  	# self.send("#{key}" )

# index_url = Nokogiri::HTML(open('http://127.0.0.1:8080/students/ryan-johnson.html'))
# index_url = 'http://127.0.0.1:8080/'

# :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio

#       def initialize(attributes)
#     		attributes.each {|key, value| self.send(("#{key}="), value)}
#   		end
# 			