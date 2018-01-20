require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    binding.pry
  end

  def call
    # box.each do |box_doc|
    #   scrape_box(box_doc)
  end

  def box
    @box ||= @doc.search("div.student-card")
  end


  def self.scrape_index_page(index_url)
    binding.pry
  #   @doc = Nokogiri::HTML(open(index_url))
  #
  # props = {}
  # props[:name] = @doc.search("h4.student-name")
  # props[:location] = @doc.search("p.student-location")
  # props[:profile_url] = @doc.search("div.student-card a")


  # <div class="student-card" id="ryan-johnson-card">
  #           <a href="students/ryan-johnson.html">
  #             <div class="view-profile-div">
  #               <h3 class="view-profile-text">View Profile</h3>
  #             </div>
  #             <div class="card-text-container">
  #               <h4 class="student-name">Ryan Johnson</h4>
  #               <p class="student-location">New York, NY</p>
  #             </div>
  #           </a>
  #         </div>
  #         ::before
  # <a href="students/ryan-johnson.html">
  #             <div class="view-profile-div">
  #               <h3 class="view-profile-text">View Profile</h3>
  #             </div>
  #             <div class="card-text-container">
  #               <h4 class="student-name">Ryan Johnson</h4>
  #               <p class="student-location">New York, NY</p>
  #             </div>
  #           </a>
  props

  end





  # self.new_from_example(index_url)
  #   properties = scraper.new
  #   properties.each do |k,v|
  #     scraper.send("#{k}=", v)
  #   end
  # end

    def self.scrape_profile_page(profile_url)

    end


end
