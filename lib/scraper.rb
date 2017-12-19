require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    card = []
    student_card = doc.css("div.student-card").each do |student|
      card << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    card
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_details = {}
    page.css("div.main-wrapper.profile").each do |d|
      binding.pry
        if d.css("div.social-icon-container a").attribute("href").value.include?('twitter')
          student_details[:twitter] = d.css("div.social-icon-container a").attribute("href").value

        elsif d.css("a + a").attribute("href").value.include?("linkedin")
          student_details[:linkedin] = d.css("a + a").attribute("href").value

        elsif d.css("a + a + a").attribute("href").value.include?("github")
        student_details[:github] = d.css("a + a + a").attribute("href").value

        elsif d.css("a + a + a + a").attribute("href").value.nil?
          student_details[:blog] = d.css("a + a + a + a").attribute("href").value
        end
        student_details[:profile_quote] = d.css("div.profile-quote").text
        student_details[:bio] = d.css("div.description-holder p").text
     end
     student_details
  end

end
