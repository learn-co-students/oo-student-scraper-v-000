require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_nodes = doc.css('div.roster-cards-container a')

    student_nodes.map { |student|
      {
        name:student.css('h4.student-name').text,
        location:student.css('p.student-location').text,
        profile_url:student.attr('href')
      }
      }
      # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile={}
    social_icons = doc.css('div.social-icon-container a')
    student_profile[:profile_quote] = doc.css('div.profile-quote').text
    student_profile[:bio] = doc.css('div.description-holder p').text
    social_icons.each {|social|
      student_profile[:linkedin] = social.attr('href') if social.attr('href').include?("linkedin")
      student_profile[:twitter] = social.attr('href') if social.attr('href').include?("twitter")
      student_profile[:github] = social.attr('href') if social.attr('href').include?("github")
      student_profile[:blog] = social.attr('href') if (!social.attr('href').include?("twitter") && !social.attr('href').include?("linkedin") && !social.attr('href').include?("github"))
    }
    student_profile
    # binding.pry
  end

end

# students = Scraper.scrape_profile_page('./fixtures/student-site/students/david-kim.html')
students_array = Scraper.scrape_index_page('./fixtures/student-site/index.html')
students_array.each {|s|
  puts "#{s[:name]} #{s[:location]}"
}
