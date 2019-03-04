require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_webpage = Nokogiri::HTML(html)
    @student_info = [] 
    learn_webpage.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a")[0]['href']
      @student_info << {:name => name, :location => location, :profile_url => profile_url}
    end
    @student_info 
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_webpage = Nokogiri::HTML(html)
    @social_hash = Hash.new
    @values = []
    profile_webpage.css("div.social-icon-container a").each do |social_icon|
      @values << social_icon['href']
    end
    twitter = @values.find {|icon| icon.include?"twitter"}
    unless twitter == nil 
      @social_hash[:twitter] = twitter
    end
    linkedin = @values.find {|icon| icon.include?"linkedin"}
    unless linkedin == nil 
      @social_hash[:linkedin] = linkedin 
    end
    github = @values.find {|icon| icon.include?"github"}
    unless github == nil 
      @social_hash[:github] = github 
    end 
    unless @values[3] == nil  
      @social_hash[:blog] = @values[3]
    end
    profile_quote = profile_webpage.css("div.profile-quote").text 
    unless profile_quote == nil 
      @social_hash[:profile_quote] = profile_quote
    end
    bio = profile_webpage.css("div.description-holder p").text 
    unless bio == nil 
      @social_hash[:bio] = bio 
    end 
    @social_hash 
  end 
end

