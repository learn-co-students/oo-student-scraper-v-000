require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #array_hashes student => student_info
    # {:name => "Abby Smith", :location}
    students = []

    html = File.read('./fixtures/student-site/index.html')    
    doc = Nokogiri::HTML(html)
    
    #item = doc.css("roster-cards-container") #doesn't work
    items = doc.css("div.roster-cards-container")
    
    cards = items.css("div.student-card")
    #cards = items.css(".student-card")
    
    #student_name = cards[0].css(".student-name").text #this works, now do it for all of them
    
    cards.each do |card|
      card_name = card.css(".student-name").text
      card_location = card.css(".student-location").text
      card_url = card.css("a")[0].attributes["href"].value
      students << {name: card_name, location: card_location, profile_url: card_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    add_items(get_doc(profile_url), student)
    student
  end
#
#
#
  def self.get_doc(profile_url)
    doc = Nokogiri::HTML(File.read(profile_url)) #below is older way of doing it
    #html = File.read(profile_url)
    #doc = Nokogiri::HTML(html)       
  end

  def self.collect_links(doc)
    doc.css(".social-icon-container").children.css("a").map { |item| item.attribute('href').value}
    
    #long way of writing this
    #REMEMBER .map is the same as .collect
    #doc.css(".social-icon-container").children.css("a").map do |item|
    # item.attribute('href').value
    #end
  end
  
  def self.add_links(search, student) #local variable student messing me up...
    search.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      else student[:blog] = link
      end
    end
  end
  
  def self.add_profile_quote(doc, student)
    student[:profile_quote] = doc.css(".profile-quote").text #if doc.css(".profile-quote")      
  end  

  def self.add_student_bio(doc, student)
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    #if doc.css("div.bio-content.content-holder div.description-holder p").text
    #  student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    #end        
  end
  
  def self.add_items(doc, student)
    add_links(collect_links(doc), student)
    add_profile_quote(doc, student)
    add_student_bio(doc, student)    
  end

end

