require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  @@all = []

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    allstudents = doc.css(".student-card")
    allstudents.each{ |item| 
      student_hash = {}
      student_hash[:name] = item.css(".student-name").text
      student_hash[:location] = item.css(".student-location").text
      student_hash[:profile_url] = item.css("a").attribute("href").value
      @@all << student_hash
    }
    
    @@all
  end

  def self.scrape_profile_page(profile_url)
    @profile_hash = {}
    #:twitter, :linkedin, :github, :blog, :profile_quote, :bio
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    allsocial = doc.css(".social-icon-container a")
    
    allsocial.each{|item| 
      #network = item.css("a").attribute("href").value
      if item.css("img").attribute("src").value.include?("twitter")
        @profile_hash[:twitter] = item.attribute("href").value
      elsif item.css("img").attribute("src").value.include?("linkedin")
        @profile_hash[:linkedin] = item.attribute("href").value
      elsif item.css("img").attribute("src").value.include?("github")
        @profile_hash[:github] = item.attribute("href").value
      elsif item.css("img").attribute("src").value.include?("rss")
        @profile_hash[:blog] = item.attribute("href").value
      end
    } 
    #social = doc.css(".social-icon-container")
    #need to extract each
    # regexex = (/([^\/])+\./).chomp(".")
    # doc.css(".social-icon-container a")[0]["href"]
    #binding.pry
    
    @profile_hash[:bio] = doc.css(".description-holder").first.text.strip
    @profile_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    
    # network = item.css("a").attribute("href").value
    # allsocial = doc.css(".social-icon-container a").attribute("href").value
    
    # if item.css("a img").attribute("src").value.include?("rss")
    #   @profile_hash[:blog] = doc.css(".social-icon-container a").attribute("href").value
    # elsif item.css("a img").attribute("src").value.include?("twitter")
    #   name = :twitter
    # elsif item.css("a img").attribute("src").value.include?("linkedin")
    #   name = :linkedin
    # elsif item.css("a img").attribute("src").value.include?("github")
    #   name = :github
    #   # if network.include?("www.")
    #   #   name = network[/([^www\.])+\./].chomp(".").to_sym
    #   # else
    #   #   name = network[/([^\/])+\./].chomp(".").to_sym
    #   # end
    # end
    
    allsocial = doc.css(".social-icon-container")
    #item.css("a").attribute("href").value[/([^\/])+\./].delete("www").delete(".").to_sym
    
    #item.css("a img").attribute("src").value
    
    allsocial.each{ |item| 
      network = item.css("a").attribute("href").value
      #binding.pry
      if item.css("a img").attribute("src").value.include?("rss")
        @profile_hash[:blog] = network
      elsif item.css("a img").attribute("src").value.include?("twitter")
        @profile_hash[:twitter] = network
      elsif item.css("a img").attribute("src").value.include?("linkedin")
        @profile_hash[:linkedin] = network
      elsif item.css("a img").attribute("src").value.include?("github")
        @profile_hash[:github] = network
      end
        # if network.include?("www.")
        #   name = network[/([^www\.])+\./].chomp(".").to_sym
        # else
        #   name = network[/([^\/])+\./].chomp(".").to_sym
        # end
    } 
    
    #binding.pry
    
    @profile_hash
    
      
    # allsocial.each{ |item| 
    #   network = item.css("a").attribute("href")
    #   profile_hash = {}
    #   network.each{|i|
    #     binding.pry
    #     if network.include?("www.")
    #       name = network[/([^www\.])+\./].chomp(".").to_sym
    #     else
    #       name = network[/([^\/])+\./].chomp(".").to_sym
    #     end
    #     profile_hash[name] = i.value
    #   }
    #   @@allprofiles << profile_hash
    # }
    #binding.pry

    
    @profile_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    @profile_hash[:bio] = doc.css(".description-holder").first.text.strip
    @profile_hash
    
  end
    
    
    
    
    #item.css("a").attribute("href").value[/([^\/])+\./].delete("www").delete(".").to_sym
    #item.css("a img").attribute("src").value
    # allsocial.each{ |item| 
    #   network = item.css("a").attribute("href")
    #   profile_hash = {}
    #   network.each{|i|
    #     binding.pry
    #     if network.include?("www.")
    #       name = network[/([^www\.])+\./].chomp(".").to_sym
    #     else
    #       name = network[/([^\/])+\./].chomp(".").to_sym
    #     end
    #     profile_hash[name] = i.value
    #   }
    #   @@allprofiles << profile_hash
    # }
    #binding.pry
    
    # if network.include?("www.")
        #   name = network[/([^www\.])+\./].chomp(".").to_sym
        # else
        #   name = network[/([^\/])+\./].chomp(".").to_sym
        # end
        
    #social = doc.css(".social-icon-container")
    #need to extract each
    # regexex = (/([^\/])+\./).chomp(".")
    # doc.css(".social-icon-container a")[0]["href"]
    #binding.pry
    
    # network = item.css("a").attribute("href").value
    # allsocial = doc.css(".social-icon-container a").attribute("href").value
    
    # if item.css("a img").attribute("src").value.include?("rss")
    #   @profile_hash[:blog] = doc.css(".social-icon-container a").attribute("href").value
    # elsif item.css("a img").attribute("src").value.include?("twitter")
    #   name = :twitter
    # elsif item.css("a img").attribute("src").value.include?("linkedin")
    #   name = :linkedin
    # elsif item.css("a img").attribute("src").value.include?("github")
    #   name = :github
    #   # if network.include?("www.")
    #   #   name = network[/([^www\.])+\./].chomp(".").to_sym
    #   # else
    #   #   name = network[/([^\/])+\./].chomp(".").to_sym
    #   # end
    # end

end

