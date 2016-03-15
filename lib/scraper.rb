require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    a = []
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card")
    students.each do |student|
      a << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"
      }
    end
    a
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    a = []
    h = {
      :profile_quote=>page.css("div.profile-quote").text,
      :bio=> page.css("div.description-holder p").text
    }
    if page.at_css("div.social-icon-container a:nth-child(1)")
        a << page.css("div.social-icon-container a:nth-child(1)").attribute("href").value
    else 
        a << "longstringthatwontbepresentinbloglink"
    end

    if page.at_css("div.social-icon-container a:nth-child(2)")
      a << page.css("div.social-icon-container a:nth-child(2)").attribute("href").value
    else
      a << "longstringthatwontbepresentinbloglink"
    end

    if page.at_css("div.social-icon-container a:nth-child(3)")        
      a << page.css("div.social-icon-container a:nth-child(3)").attribute("href").value
    else
      a << "longstringthatwontbepresentinbloglink"
    end

    if page.at_css("div.social-icon-container a:nth-child(4)")
      a << page.css("div.social-icon-container a:nth-child(4)").attribute("href").value
    else
      a << "longstringthatwontbepresentinbloglink"
    end

    a.each do |value|
      #binding.pry
      case 
        when value.include?("twitter")
          h[:twitter] = value
        when value.include?("git")
          h[:github] = value
        when value.include?("longstringthatwontbepresentinbloglink")
        when value.include?("linked")
          h[:linkedin] = value
        else
          h[:blog] = value
      end
    end



    #TODO --- wordy, refactor?
    
    
    h
  end

end

