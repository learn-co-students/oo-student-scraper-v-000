require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

      @doc = Nokogiri::HTML(File.open(index_url))
      students = []

      @doc.css("div.roster-cards-container").each do |student|
        student.css("div.student-card").each do |card|
          students << {:name => card.css("h4.student-name").text,
          :location => card.css("p.student-location").text, :profile_url => card.css("a").attr("href").value}
        end
      end
      students
  end

  def self.scrape_profile_page(profile_url)

    @page = Nokogiri::HTML(File.open(profile_url))
    student_page = {}

    # PROFILE LINKS
    links = @page.css("div.social-icon-container").children.css("a")
    links.each do |link|
        if link.attr("href").include?("twitter")
          student_page[:twitter] = link.attr('href')
        elsif link.attr("href").include?("linkedin")
          student_page[:linkedin] = link.attr('href')
        elsif link.attr("href").include?("github")
          student_page[:github] = link.attr('href')
        elsif link.attr("href").include?(".com")
          student_page[:blog] = link.attr('href')
        end
      end

      # STUDENT QUOTE
      student_page[:profile_quote] = @page.css("div.profile-quote").text

      # STUDENT BIO
      student_page[:bio] = @page.css("div.description-holder p").text

      # RETURNED HASH
      student_page
  end

end
