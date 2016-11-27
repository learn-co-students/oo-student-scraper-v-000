class Scraper

  NETWORKS = ["linkedin", "github", "twitter"]


  def self.scrape_index_page(index_url)
  	students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
    	student = {}
    	student[:name] = card.css("h4.student-name").text
    	student[:location] = card.css("p.student-location").text
    	student[:profile_url] = "./fixtures/student-site/" + card.css("a").attribute("href").value
    	students.push(student)
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  	doc = Nokogiri::HTML(open(profile_url))
  	socials = doc.css(".social-icon-container a")
  	links = []
  	socials.each { |social| links << social.attribute("href").value }
  	profile = {}
  	NETWORKS.each do |network|
  		profile[:"#{network}"] = links.detect {|a| a.include?("#{network}")} if links.detect {|a| a.include?("#{network}")}
  	end
    profile[:blog] = links.last unless links.size < 3
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text
    profile
  end

end

