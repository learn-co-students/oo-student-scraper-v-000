require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect { |c| create_student_hash(c) }
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    urls = doc.css(".social-icon-container").css("a")
    
    social_links = {}
    self.create_social_pairs_hash(urls, social_links)
    
    social_links.merge({ profile_quote: doc.css(".profile-quote").text,
      bio: doc.css(".description-holder").css("p").text })
    
  
  end




#private
  
  def self.create_student_hash(student_card)
    { name: student_card.css('.student-name').text,
      location: student_card.css('.student-location').text, 
      profile_url: student_card.css("a").attribute("href").value }
  end

  def self.create_social_pairs_hash(urls, social_hash)
    #think about #tap for this
    urls.each { |e| add_to_social_hash(e, social_hash)}
    social_hash
  end

  def self.add_to_social_hash(url, hash)
    if url.attribute("href").value.include?("twitter")
      hash[:twitter] = url.attribute("href").value
    elsif url.attribute("href").value.include?("linkedin")
      hash[:linkedin] = url.attribute("href").value
    elsif url.attribute("href").value.include?("github")
      hash[:github] = url.attribute("href").value
    else
      hash[:blog] = url.attribute("href").value
    end
  end
  
  def self.url_includes?(url, name)
    url.attribute("href").value.include?(name)
  end
  
  def self.add_to_hash(url, name)
   hash[name.to_sym] = url.attribute("href").value
  end

end

