require 'open-uri'
require 'pry'


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
  	links = url.css('.main-wrapper')
  	links.each do |link|
  	link.css('.vitals-container').search('a').each do |site|
    info.each do |k, v|

          if site.attribute('href').value.slice(k.to_s).eql?(k.to_s)
	 					info[k] = site.attribute('href').value

	 				elsif k.eql?(:blog) && info.none?{|a,b| site.attribute('href').value.slice(a.to_s).eql?(a.to_s)} && site.attribute('href').value.include?("http://")info[k] = site.attribute('href').value
	 				end
	 			end
	 		end

	 		link.css('.vitals-container').search('[class^="profile"]').each do |klass|info.each do |k,v|
	 				if info[k].empty? && klass.attribute('class').value.sub(/[-_]/, " ").eql?(k.to_s.sub(/[-_]/, " "))info[k] = klass.text
	 				end
	 			end
	 		end
	 		link.css('.details-container').search('[class^="bio"]').each do |klass|info.each do |k,v|
	 				if info[k].empty? && klass.attribute('class').value.slice(k.to_s).eql?(k.to_s)info[k] = klass.css('p').text
	 				end
	 			end
	 		end
	 	end
	 	info.delete_if {|k, v| v == ""}
	end

end
