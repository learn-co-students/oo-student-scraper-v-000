require 'open-uri'
require 'pry'

class Scraper

  


  def self.scrape_index_page(index_url)
    students = []
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    doc.css("div.roster-cards-container").each do |cards|
      
      cards.css(".student-card a").each do |student|
        student_url = student.attr('href')
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
    students << {name: student_name, location: student_location, profile_url: student_url }
       end
     end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_info= {}
    html = open (profile_url)
    doc = Nokogiri::HTML(html)
    links = doc.css("div.social-icon-container").children.css("a").collect {|socials| socials.attribute("href").value}
      links.each do |separate_links|
        if separate_links.include?("twitter") 
          student_info[:twitter] = separate_links
        elsif separate_links.include?("github")
          student_info[:github] = separate_links
        elsif separate_links.include?("linkedin")
          student_info[:linkedin] = separate_links
        else 
          student_info[:blog] = separate_links
          # binding.pry
      end
    end
    student_info[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    student_info[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text if doc.css("div.vitals-text-container div.profile-quote")
    student_info
  end
end


# doc.css("div.social-icon-container")
# doc.css("div.social-icon-container").children.css("a")
# twitter = doc.css("div.social-icon-container").children.css("a").attr("href").text
# "#{student_info.attr('href')}"
# bio = doc.css("div.bio-content.content-holder div.description-holder p")
# quote = doc.css("div.vitals-text-container div.profile-quote").text 





