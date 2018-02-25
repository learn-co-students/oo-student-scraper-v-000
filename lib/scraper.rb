require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #get the page
    doc = Nokogiri::HTML(open(index_url))
    list_of_student =[]
    individual_card = doc.css(".student-card")
    student_card = doc.css(".student-card").each do |individual_card|
      #binding.pry
      list_of_student.push(collect_student_info(individual_card))
    end
    #binding.pry
    list_of_student
  end

  def self.collect_student_info(student_card)
    student_info={}
    student_cards_text_container = student_card.css(".card-text-container").first
    student_info[:name] = student_cards_text_container.css("h4").text
    student_info[:location] = student_cards_text_container.css("p").text
    student_info[:profile_url] = student_card.css("a")[0]["href"]
    student_info
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    profile_vitals = doc.css(".vitals-container").css(".social-icon-container")
    profile_info[:twitter] = profile_vitals.css("a")[0]["href"]
    profile_info[:linkedin] = profile_vitals.css("a")[1]["href"]
    profile_info[:github] = profile_vitals.css("a")[2]["href"]
    profile_info[:blog] = profile_vitals.css("a")[3]["href"]
    profile_info[:profile_quote] =  doc.css(".profile-quote").text
    progfile_info[:bio] = doc.css(".details-container").css(".bio-block").css(".bio-content").css(".description-holder").css("p").text
    binding.pry
  end


end
