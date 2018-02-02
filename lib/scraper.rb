require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    index_url = "./fixtures/student-site/index.html"
    doc = Nokogiri::HTML(open(index_url))

     name = doc.css("h4.student-name")
     names = []
     name.select do |n|
      names << n.text
     end
     names

      location = doc.css("p.student-location")
      locations = []
      location.select do |l|
        locations << l.text
      end
      locations

      profile_url = doc.css(".student-card a[href]")
      profile_urls = []
      profile_url.select do |url|
       profile_urls << url['href']
      end
      profile_urls




      student_index = []
      hash = {}
      x = 0
      names.each do |name|
        student_index << {:name => name, :location => locations[x], :profile_url => profile_urls[x]}
        x += 1
      end
      student_index

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    twitter = []
    linkedin = []#doc.css("a[href]").value
    github = []#doc.css("a[href]").value
    blog = []#doc.css("a[href]").value


      doc.css("div.social-icon-container a").map do |value|
        if value['href'].include?('twitter')
          twitter << value['href']
        end
      end
      doc.css("div.social-icon-container a").map do |value|
        if value['href'].include?('linkedin')
          linkedin << value['href']
        end
      end
      doc.css("div.social-icon-container a").map do |value|
        if value['href'].include?('github')
          github << value['href']
        end
      end
      doc.css("div.social-icon-container a").map do |value|
       if !(value['href'].include?("github")) &&
          !(value['href'].include?("linkedin")) &&
          !(value['href'].include?("twitter"))
          blog = value['href']
       end
     end

      profile_quote = doc.css(".profile-quote").text
      bio =  doc.css(".description-holder p").text

      #if twitter = "" || linkedin = "" || github = "" || blog = "" ||
    #  profile_quote = "" || bio = ""
      #  return twitter = nil || linkedin = nil || github = nil || blog = nil ||
      #  profile_quote = nil || bio = nil
    #  end
    scraped_student = {
        :twitter => twitter[0],
        :linkedin => linkedin[0],
        :github => github[0],
        :blog => blog,
        :profile_quote => profile_quote,
        :bio => bio
      }
      scraped_student.delete_if {|key, value| value == [] || value == nil}
      scraped_student
  end

end
