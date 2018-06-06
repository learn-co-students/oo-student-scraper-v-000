require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    list = Nokogiri::HTML(html)
    names = list.css(".student-name")
    names_array = []
    names.each do |item|
      names_array << item.text
    end
    #names_array

    locations = list.css(".student-location")
    location_array = []
    locations.each do |item|
      location_array << item.text
    end
    #location_array

    webpages = list.css(".student-card a[href]")
    webpage_array = []
    webpages.select do |item|
    webpage_array << item['href']
    end
    #webpage_array

    master_array = []
    hash = {}
    index = 0
    names_array.each do |name|
    master_array << {:name => name, :location => location_array[index], :profile_url => webpage_array[index]}
    index += 1
    end
    master_array

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_twitter = []
    student_linkedin = []
    student_github = []
    student_youtube = []
    student_blog = []

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("twitter")
        student_twitter << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("linkedin")
        student_linkedin << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("github")
        student_github << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if !(link['href'].include?("github")) &&
         !(link['href'].include?("linkedin")) &&
         !(link['href'].include?("twitter"))
         student_blog = link['href']
      end
    end

    student_quote = doc.css(".profile-quote").text
    student_bio = doc.css(".description-holder p").text

    student_twitter
    student_linkedin
    student_github
    student_youtube
      if student_youtube = ""
        student_youtube = nil
      end
    student_blog

    content = {:twitter=>student_twitter[0],
               :linkedin=>student_linkedin[0],
               :github=>student_github[0],
               :profile_quote=>student_quote,
               :blog=>student_blog,
               :bio=> student_bio}
    content.delete_if {|key, value| value == [] || value == nil}
    content
 end


end
