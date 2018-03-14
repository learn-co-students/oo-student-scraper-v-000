require 'open-uri'
require 'pry'

class Scraper

	def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_index_page(index_url)
    index_page = self.get_page(index_url)
    student_cards = index_page.css(".student-card")
    array = student_cards.map do |card|
    	profile_url=index_url+"/"+card.css("a").attr('href').value
    	{
    		:name => card.css(".student-name").text,
    		:location => card.css(".student-location").text, 
    		:profile_url => profile_url
    	}
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    profile_page = self.get_page(profile_url)
    ##Add social media
    profile_info = {}
    profile_page.css(".social-icon-container a").each do |entry|
    	#binding.pry
    	a_value=entry.attr('href')

    	img_value=entry.css("img").attr('src').value
    	
    	profile_info[:github]=a_value if a_value.include?("github.com")
    	profile_info[:linkedin]=a_value if a_value.include?("linkedin.com")
    	profile_info[:twitter]=a_value if a_value.include?("twitter.com")
    	profile_info[:blog]=a_value if img_value.include?("rss-icon.png")
    end
    ##
    profile_info[:profile_quote]=profile_page.css(".profile-quote").text
    profile_info[:bio]=profile_page.css(".bio-content .description-holder").text
    profile_info
  end

end

