require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "./fixtures/student-site/index.html")

    return_array = Array.new

    html = open(index_url)
    doc = Nokogiri::HTML(html)


    #name = doc.css(".student-card").first.css("h4").text
    #location = doc.css(".student-card").first.css("p").text

    #url = doc.css(".student-card a[href]").first['href']
    #url2 = doc.css(".student-card a").first['href']
    #url3 = doc.css(".student-card").first.css("a").first['href']

    #url2 = doc.css(".student-card").first.css('a').css('href')
    #url3 = doc.css(".student-card").first['href']

    doc.css(".student-card").each do |student|
          new_h = Hash.new
          new_h[:name] = student.css("h4").text
          new_h[:location] = student.css("p").text
          new_h[:profile_url] = student.css("a").first['href']
          return_array << new_h
        end

    return_array

  end



  def self.scrape_profile_page(profile_url = "./fixtures/student-site/students/ryan-johnson.html")

    return_hash = Hash.new

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    links = doc.css('.social-icon-container').css("a").first['href']

    doc.css('.social-icon-container').css("a").each do |link|
      if link['href'].include?("twitter")
        return_hash[:twitter] = link['href']
      elsif link['href'].include?("linkedin")
        return_hash[:linkedin] = link['href']
      elsif link['href'].include?("github")
        return_hash[:github] = link['href']
      else
        return_hash[:blog] = link['href']
      end

    end

    profile_quote_text = doc.css('.profile-quote').text
    #profile_quote_attr = doc.css('.vitals-text-container').css('#div')
    #profile_quote_attr2 = doc.css('.vitals-text-container').first

    return_hash[:profile_quote] = doc.css('.profile-quote').text
    return_hash[:bio] = doc.css('.description-holder').css("p").text

    return_hash


  end

end
