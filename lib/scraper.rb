require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
   doc = Nokogiri::HTML(open(index_url))
   scraped_students = []
   doc.css("div.student-card").each do |card|
     # we create the student hash
     student_hash = Hash.new

     student_hash[:name] = card.css(".student-name").text
     student_hash[:location] = card.css(".student-location").text
     student_hash[:profile_url] =  card.css("a").attr("href").value
     #binding.pry


     # we can populate the scraped_students array with the student hash
     scraped_students << student_hash
   end
   return scraped_students

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      scraped_students = []
      student_hash = Hash.new

      doc.css('.vitals-container .social-icon-container a').each do |social|
       if social.css('img').attr('src').value.include?("twitter")
          student_hash[:twitter] = social.attr('href')
       elsif social.css('img').attr('src').value.include?("linkedin")
           student_hash[:linkedin] = social.attr('href')
       elsif social.css('img').attr('src').value.include?("github")
           student_hash[:github] = social.attr('href')
       elsif social.css('img').attr('src').value.include?("rss")
           student_hash[:blog] = social.attr('href')
         end
       end

     doc.css('html').each do |details|
       student_hash[:profile_quote] = details.css('.profile-quote').text.strip
       student_hash[:bio] = details.css('.bio-content.content-holder .description-holder').text.strip

     end
     student_hash
   end

 end

