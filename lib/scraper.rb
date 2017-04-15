require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    learn_student_page = Nokogiri::HTML(html)

    student_list = learn_student_page.css("student-card card-text-container")
    binding.pry
    student_array = []
    #
    # learn_student_page.css("student-card").each do |student|
    #   name = student.css("h4.student-name").text
    #
    # end

  end

  def self.scrape_profile_page(profile_url)

  end

end
