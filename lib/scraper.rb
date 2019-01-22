require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
   doc = Nokogiri::HTML(html)
  names = []
  locations = []
  urls = []

  doc.css("h4").each do |name|
  names << name.text
  end

  doc.css("p").each do |location|
  locations << location.text
  end

  doc.css("a").each do |url|
  urls << url.attribute("href").value
  end

  output = []

  names.each.with_index do |object,index|
  hash_entry = {}
  hash_entry[:name]=object
  hash_entry[:location]=locations[index]
  hash_entry[:profile_url]=urls[index+1]
  output << hash_entry
  end
  return output

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
   doc = Nokogiri::HTML(html)
  output = {}
  output[:bio] = doc.css("div .description-holder p").text
  output[:profile_quote] = doc.css("div .profile-quote").text



  social_stuff = []
  doc.css("div .social-icon-container a").each do |social|
  social_stuff << social.attribute("href").value
  end
  social_stuff.each do |social|
  if social.include?("twitter")
    output[:twitter] = social
  elsif social.include?("linkedin")
    output[:linkedin] = social
  elsif social.include?("github")
    output[:github] = social
  elsif social.include?("youtube")
  else
    output[:blog] = social
  end
end

return output
end
end
