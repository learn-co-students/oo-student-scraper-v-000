require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    index_page = Nokogiri::HTML(open(index_url))

    index_page.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile = "./fixtures/student-site/#{student.attr('href')}"

        student_info << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    student_info
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    profile_page = Nokogiri::HTML(open(profile_url))

    #collect all the students social links into one array
    student_links = profile_page.css(".social-icon-container").children.css("a").collect {|item| item.attribute("href").value}

    #check all the links in the array and add them to the final student_profile hash to appropriate key
    student_links.each do |link|
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
    #get and store quote if it exists
    #student_profile[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote").text
    student_profile[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text if profile_page.css("div.vitals-text-container div.profile-quote").text

    #get bio and store in hash with correct key if it exists
    student_profile[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p").text

    student_profile #return
  end

end
