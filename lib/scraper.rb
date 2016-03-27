require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open("#{index_url}"))    
    @students = []
    @student_html = @doc.css("div.student-card")
    @student_html.each do |student|
      @student_hash ={}
      @student_hash[:name] = student.css(".student-name").text
      @student_hash[:location] = student.css(".student-location").text
      base_url = "http://127.0.0.1:4000/"
      student_url = student.css("a").map{|link| link['href']}.first.to_s
      @student_hash[:profile_url] = base_url + student_url
      @students << @student_hash
    end
    @students
  end

  def self.scrape_profile_page(profile_url)
    @doc = Nokogiri::HTML(open("#{profile_url}"))    
    #:twitter, :linkedin, :github, :blog,:profile_quote, :bio
    @profile_info = {}
    @social_links = @doc.css(".social-icon-container a")
    @social_links.each do |link|
      link = link['href']
      if link.include? "twitter"
        @profile_info[:twitter] = link
      elsif link.include? "linkedin"
        @profile_info[:linkedin] = link
      elsif link.include? "github"
        @profile_info[:github] = link
      else
        @profile_info[:blog] = link
      end
    end        

    @profile_info[:profile_quote] = @doc.css(".profile-quote").text
    @profile_info[:bio] = @doc.css(".bio-content .description-holder p").text
    @profile_info
  end

end

