require 'open-uri'
require 'pry'
require 'nokogiri'
  class Scraper
    attr_accessor :page_loc
    @page_loc = "http://165.227.31.208:56222/fixtures/student-site/"
    def self.index_to_param(index_url)
      doc = Nokogiri::HTML(open(@page_loc))
      studs_divs = doc.css(".student-card a h4")
      studs_names = []
      studs_divs.each do |stud_div|
        studs_names << stud_div.text
      end
      studs_param = []
      studs_names.each do |name|
        name.gsub!(" ", "-")
        name = "#{name}.html"
        studs_param << name.downcase
      end
      studs_param
    end
    def self.scrape_index_page(index_url)
      studs_param = index_to_param(index_url)
      students_hashes = []
      studs_param.each do |param|
        doc = Nokogiri::HTML(open("#{@page_loc}students/#{param}"))
        stu = {}
        stu[:profile_url] = param
        stu[:name] = param.gsub("-", " ").gsub(".html", "").split.map(&:capitalize).join(' ')
        stu[:location] = doc.css(".vitals-text-container h2").text binding.pry
        students_hashes << stu
      end
      students_hashes
    end
    def self.scrape_profile_page(profile_url)
    end
  end
