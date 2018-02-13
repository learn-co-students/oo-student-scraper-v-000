require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html= open(index_url)
    doc= Nokogiri::HTML(html)
    elems= doc.xpath("//*[@href]")
    array= []
    #i= 0
    # elems.map do |x|
    #   #elems[4].attr("href") gives the first student's
    #   hash[:profile_url][i] = x.attr("href") #the first student is line element index [4], this way would start from beginnin !
    #   i+= 1
    # end
    # or

      i=4
      index= 0
      until i== elems.length
      array[index] = {}
      array[index][:profile_url] = elems[i].attr("href")
      i+=1
      index+=1
    end

    l=0
    doc.css("h4").map do |x|

      array[l][:name] = x.text#gives string of names
      l+=1
    end
    z=0
    doc.css("p").map do |x|

      array[z][:location] = x.text# gives string of
      z+=1
    end
    array
  end

  def self.scrape_profile_page(profile_url)

      html= open(profile_url)
      doc= Nokogiri::HTML(html)
      elems= doc.xpath("//*[@href]")
      hash= {}
      binding.pry

      hash[:profile_quote]= doc.css(".profile-quote").text  #quote
      hash[:bio]= doc.css("p").text #bio

      if elems[4].attr("href").include?("twitter")
        hash[:twitter]= elems[4].attr("href")
      elsif elems[4].attr("href").include?("linkedin")
        hash[:linkedin]= elems[4].attr("href")
      elsif elems[4].attr("href").include?("github")
        hash[:github]= elems[4].attr("href")
      else
        hash[:blog]= elems[4].attr("href")
      end

      if elems[5].attr("href").include?("linkedin")
        hash[:linkedin]= elems[5].attr("href")
      elsif elems[5].attr("href").include?("twitter")
        hash[:twitter]= elems[5].attr("href")
      else
        hash[:blog]= elems[5].attr("href")
      end

      if elems[6] != nil
        if elems[6].attr("href").include?("github")
          #binding.pry
        hash[:github]= elems[6].attr("href")
        else
        hash[:blog]= elems[6].attr("href")
        end
      end

      if elems[7] != nil
        if elems[7].attr("href").include?(".com")
          #hash[:blog]= elems[7].attr("href")
        end
      end

      #
      hash
    end

end
