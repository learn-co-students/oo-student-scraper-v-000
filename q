
[1mFrom:[0m /home/molliestein-57461/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 11 Scraper.scrape_index_page:

     [1;34m7[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m8[0m:     html = [1;34;4mFile[0m.read(index_url)
     [1;34m9[0m:     student_page = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m10[0m:     students = []
 => [1;34m11[0m:     binding.pry
    [1;34m12[0m:     student_page.css([31m[1;31m"[0m[31m.student-card[1;31m"[0m[31m[0m).each { |student|
    [1;34m13[0m:   [1;34m#    title = project.css("h2.bbcard_name strong a").text[0m
    [1;34m14[0m:       [1;34m#projects[title.to_sym] = {[0m
    [1;34m15[0m:       students << {
    [1;34m16[0m:         [33m:name[0m => student.css([31m[1;31m"[0m[31m.student-name[1;31m"[0m[31m[0m).text
    [1;34m17[0m:     [1;34m#    :name => student.css("div.project-thumbnail a img").attribute("src").value,[0m
    [1;34m18[0m:     [1;34m#    :location => student.css("p.bbcard_blurb").text,[0m
    [1;34m19[0m:     [1;34m#    :profile_url => student.css("ul.project-meta span.location-name").text,[0m
    [1;34m20[0m:         [1;34m#:percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i[0m
    [1;34m21[0m:       }
    [1;34m22[0m: 
    [1;34m23[0m:       [1;34m#students << {name: student_name, location: student_location, profile_url: student_profile_link}[0m
    [1;34m24[0m:     }
    [1;34m25[0m: 
    [1;34m26[0m:     binding.pry
    [1;34m27[0m:     students
    [1;34m28[0m: 
    [1;34m29[0m: 
    [1;34m30[0m: [32mend[0m

