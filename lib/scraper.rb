require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
      doc.css(".student-card").each do  |s|
        student_hash = Hash.new
        student_hash[:name] = s.css("h4.student-name").text
        student_hash[:location] = s.css("p").text
        student_hash[:profile_url] = s.css("a").first.attributes['href'].value
        students << student_hash
        end
        students
   end

#name #doc.css(".student-card").first.css("h4").text
#location #doc.css(".student-card").first.css("p").text
#profile-url #doc.css('.student-card').first.css("a").first.attributes['href'].value

#doc.css(".student-card").each { |student| puts student.css("h4").text }
#doc.css(".student-card").each { |student| puts student.css("p").text }
#doc.css('.student-card').each { |student| puts student.css("a").first.attributes['href'].value }

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile_hash = Hash.new
    links = page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
       if link.include?("twitter")
         profile_hash[:twitter] = link
       elsif link.include?("linkedin")
         profile_hash[:linkedin] = link
       elsif link.include?("github")
         profile_hash[:github] = link
       else
         profile_hash[:blog] = link
       end
     end
     profile_hash[:profile_quote] = page.css("div.profile-quote").text
     profile_hash[:bio] = page.css(".description-holder").first.css("p").text
     profile_hash
   end
    # page.css(".main-wrapper.profile").each do |s|
    #    profile_hash[:twitter] = s.css("a")[1].attributes['href'].value
    #    profile_hash[:linkedin] = s.css("a")[2].attributes['href'].value
    #    profile_hash[:github] = s.css("a")[3].attributes['href'].value
    #    profile_hash[:blog] = s.css("a")[4].attributes['href'].value
    #    profile_hash[:profile_quote] = s.css("div.profile-quote").text
    #    profile_hash[:bio] = s.css("p").text
      #  if links.include?("twitter")
      #    profile_hash[:twitter] = s.css("a")[1].attributes['href'].value
      #  end
      #  end
      #  profile_hash

end
