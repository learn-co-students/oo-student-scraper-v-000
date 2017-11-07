require 'open-uri'
require 'pry'
#index.html = fixtures/student-site/index.html
class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").each {|e|
      students << {
        :name => e.css("div.card-text-container h4.student-name").text,
        :location => e.css("div.card-text-container p.student-location").text,
        :profile_url => e.css("a").attribute("href").value
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)

    student = {}
    social =  doc.css("div.vitals-container div.social-icon-container")
    details = doc.css("div.details-container div.bio-block.details-block div.bio-content.content-holder")



    social.css("a").each{|e|
      the_url = e.attribute("href").value
      ["twitter","github","linkedin"].each{|i|
        if the_url.include?(i)
          student[i.to_sym] = the_url
        end
      }
    }

    #binding.pry

    student.merge({
      :blog => "blog",
      :profile_quote => doc.css("div.vitals-container div.vitals-text-container div.profile-quote").text,
      :bio => details.css("div.description-holder p").text,
    })
  end

end
