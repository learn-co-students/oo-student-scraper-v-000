require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    p=[]
    html=open(index_url)
    doc=Nokogiri::HTML(html)
    urls=doc.css('.student-card a').collect{|x| x.attribute('href').value}
    names=doc.css('.card-text-container .student-name').collect{|x| x.text}
    locations=doc.css('.card-text-container .student-location').collect{|x| x.text}
    i=0
    while i<urls.length 
      h={}
      h[:profile_url]=urls[i]
      h[:name]=names[i]
      h[:location]=locations[i]
      p << h 
      i+=1
    end
    p
    
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url)
    doc=Nokogiri::HTML(html)
    h={}
    sns=['twitter','linkedin','github']
    i=0 
    while i < doc.css('.social-icon-container a').length
      a=doc.css('.social-icon-container a')[i].attribute('href').value
      b=doc.css('.social-icon-container img')[i].attribute('src').value
      sns.each{|x| 
        if b.include?(x)
          h[x.to_sym]=a
        end
      }
      h[:blog]=a if b.include?('rss')
      i+=1
    end
    h[:profile_quote]=doc.css('.profile-quote').text
    h[:bio]=doc.css('.description-holder p').text
    h
    #binding.pry
  end
end



