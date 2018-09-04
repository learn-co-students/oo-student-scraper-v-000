require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html_content = open(index_url)
    node_site = Nokogiri::HTML(html_content)

    scraped_list=[]

    node_site.css(".roster-cards-container .student-card").each do |card|
      scraped_list << {
                        name: "#{card.css(".student-name").text}",
                        location: "#{card.css(".student-location").text}",
                        profile_url: "#{card.css("a").first["href"]}"
                      }
    end
    scraped_list
  end

  def self.scrape_profile_page(profile_url)
    html_content= open(profile_url)
    scraped_content=Nokogiri::HTML(html_content)
    hash={}

    scraped_content.css(".vitals-container").each do |card|
      count=0
      num_social=card.css(".social-icon-container a").count
      while count < num_social
        value = card.css(".social-icon-container a")[count]["href"]
        key=value.scan(/\/\b(...*)\./).flatten[0]
          if !key.nil?
            key = key.split(".")[-1] if key.include?(".")
              if key == "twitter" || key == "github" || key == "linkedin"
                key=key.to_sym
              else
                key=:blog
              end

          hash[key]= value #if value.length >2
          end
        count+=1
      end
      hash[:profile_quote]= "#{card.css(".profile-quote").text.strip}" #card.css(".profile-quote").text.split('"')
    end
    scraped_content.css(".details-container").each do |card|
    hash[:bio]= "#{card.css(".bio-block .description-holder").text.strip}"
    end
    hash
    # binding.pry

  end

end
