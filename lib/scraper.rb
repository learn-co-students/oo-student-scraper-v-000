require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    holder = []
    holder_two = []
    holder_three = []
    students = []

    # student name
    doc.css(".student-name").collect do |item|
      holder << item.text
    end

    #student location
    doc.css(".student-location").collect do |item|
      holder_two << item.text
    end

    #student URL
    doc.css("div.student-card a").collect do |item|
      holder_three << item['href']
    end

    #create hash and push to array for return
    counter = 0
    while counter < holder.length
      students << {:name => holder[counter], :location => holder_two[counter], :profile_url => holder_three[counter]}
      counter += 1
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))

    profile_quote = doc.css(".profile-quote").text
    bio = doc.css("div.description-holder p").text

    links_holder = []

    links = doc.css(".social-icon-container a")
    links.each do |link|
      links_holder << link['href']
    end

    twitter = links_holder.select {|item| item.include?("twitter")}
    links_holder.delete(twitter[0])
    linkedin = links_holder.select {|item| item.include?("linkedin")}
    links_holder.delete(linkedin[0])
    github = links_holder.select {|item| item.include?("github")}
    links_holder.delete(github[0])
    blog = links_holder[0]

    student_hash = {:twitter => twitter[0], :linkedin => linkedin[0], :github => github[0], :blog => blog, :profile_quote => profile_quote, :bio => bio}
    clean_hash = student_hash.delete_if {|k, v| v == nil}
    clean_hash
  end

end
