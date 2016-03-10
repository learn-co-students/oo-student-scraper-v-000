require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students_array = []

    doc.search("div.student-card").each do |student|
      name = student.search("h4.student-name").text
      location = student.search("p.student-location").text
      sub = student.search("a").attribute("href").value
      students_array << {
        :name => name,
        :location => location,
        :profile_url => "#{index_url}#{sub}"
      }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    #the easy grabs using .search method and direct element/class relationship
    student = {}
    student[:profile_quote] = doc.search("div.profile-quote").text
    student[:bio] = doc.search("div.description-holder p").text
    #iterate over each 'a' element and set the 'href' attribute value equal to sociallink
    doc.search("div.social-icon-container a").each do |socialnodes|
      sociallink = socialnodes.attribute("href").value
      if sociallink.include?("twitter")
        student[:twitter] = sociallink
      elsif sociallink.include?("linkedin")
        student[:linkedin] = sociallink
      elsif sociallink.include?("github")
        student[:github] = sociallink
      else
        student[:blog] = sociallink
      end
    end
    student
  end
end



