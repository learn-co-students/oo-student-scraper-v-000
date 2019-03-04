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
    keys = [:twitter, :linkedin, :github, :blog, :profile_quote, :bio]
    @values = []
    profile_webpage.css("div.social-icon-container a").each do |social_icon|
      @values << social_icon['href']
    end
    @social_hash[:twitter] = @values.find {|icon| icon.include?"twitter"}
    @social_hash[:linkedin] = @values.find {|icon| icon.include?"linkedin"}
    @social_hash[:github] = @values.find {|icon| icon.include?"github"}
    unless @values[3].empty? 
      @social_hash[:blog] = @values[3]
    end 
    binding.pry 
  end 
=begin 
    i = 0
    keys.each do |key|
      @social_hash[key] = values[i]
      i += 1 
    end 
    @social_hash[:profile_quote] = profile_webpage.css("div.profile-quote").text 
    @social_hash[:bio] = profile_webpage.css("div.description-holder p").text 
    @social_hash
  end
=end 

end

