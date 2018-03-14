require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    if index_url.include? "http://127.0.0.1:4000/"
      index_url = "http://127.0.0.1:4000/"
    end
    html = open(index_url)
    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css("div.student-card").each do |card|
    students << { :name => card.css("div.card-text-container h4.student-name").text,
      :location => card.css("div.card-text-container p.student-location").text,
      :profile_url => "http://127.0.0.1:4000/" + card.css("a")[0]['href'] }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_url.slice!(/fixtures\Wstudent-site\W/)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)

    student_hash =  {
        :profile_quote => profile_page.css("div.vitals-text-container div.profile-quote").text,
        :bio => profile_page.css("div.description-holder p").text
      }
    profile_page.css("div.social-icon-container a"). each do |link|
        if link['href'].include? "twitter"
          student_hash[:twitter] = link['href']
        elsif link['href'].include? "linkedin"
          student_hash[:linkedin] = link['href']
        elsif link['href'].include? "github"
          student_hash[:github] = link['href']
        else
          student_hash[:blog] = link['href']
        end
    end
    student_hash
  end

end

