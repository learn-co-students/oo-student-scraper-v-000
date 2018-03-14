require 'open-uri'
require 'pry'


class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
     student_cards = doc.css(".student-card")

     student_cards.collect do |student|
      {
        name: student.css(".student-name").text,
         location: student.css(".student-location").text,
         profile_url: student.css("a").attr("href").text
       }
     end
    end



  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    links = profile.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end

    end
    student_profile[:profile_quote] = profile.css(".profile-quote").text
    student_profile[:bio] = profile.css(".description-holder p").text

    student_profile



end

end
