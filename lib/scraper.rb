require 'open-uri'


class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    #html = File.open(index_url)
    #scraped_page = Nokogiri::HTML(html)
    
    results = []
    
    html.css(".roster-cards-container .student-card").each do |student|
      student_hash = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      } 
      results << student_hash
    end
    results
  end

  #name = html.css(".student-card").first.css("h4").text
  #location = html.css(".student-card").first.css("p").text
  #url html.css(".student-card").first.css("a").attribute("href").value


  def self.scrape_profile_page(profile_url)
    #html = File.open(profile_url)  #another way to open 
    scraped_page = Nokogiri::HTML(open(profile_url))

    #grab social media text elements and add them to an array 
    social_elements = []

    scraped_page.css(".social-icon-container").css("a").each do |el|
      social_elements <<  el.attribute("href").value
    end

    # start a hash - result asks for a hash 
    student = {}

    # iterate through the social elements array and create hash keys and values
    # if the element string, contains the appropriate info, it becomes the value of a hash key
    social_elements.each do |element|
      student[:twitter] = element if element.include?("twit")
      student[:linkedin] = element if element.include?("link")
      student[:github] = element if element.include?("git")
      student[:blog] = element if element.include?((scraped_page.css("div.vitals-container h1").text.downcase.split.first)) unless element.include?("link") 
    end

    #add the rest of the items 
      student[:profile_quote] = scraped_page.css("div.profile-quote").text
      student[:bio] = scraped_page.css("div.bio-content.content-holder div.description-holder p").text

      student  #return the student hash
  end

end


# notes from scraping 


#div.vitals-container
# :twitter = scraped_page.css(".social-icon-container a").attribute("href").value
#scraped_page.css(".social-icon-container").css("a").each do |el|
# puts  el.attribute("href").value 
#end  


# :linkedin = above comboed with twitter 
# :github = above comboed with twitter 
# :blog = above comboed with twitter 
# :profile_quote = scraped_page.css("div.profile-quote").text

#div.details-container
# :bio = scraped_page.css("div.bio-content.content-holder div.description-holder").text
# dont need but its the school - scraped_page.css("div.education-content.content-holder div.description-holder h4").text


    #student = {
     #   :twitter => scraped_page_social_elements[0] 
      #  :linkedin => scraped_page_social_elements[1], 
      #  :github => scraped_page_social_elements[2], 
      #  :blog => scraped_page_social_elements[3]
      #}

# p Scraper.scrape_profile_page("./fixtures/student-site/students/david-kim.html")

