
[1mFrom:[0m /home/efkarst/oo-student-scraper-v-000/lib/scraper.rb @ line 19 Scraper.scrape_index_page:

     [1;34m7[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m8[0m:   html = open(index_url)
     [1;34m9[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m10[0m:   students = []
    [1;34m11[0m:   [1;34m#binding.pry[0m
    [1;34m12[0m: 
    [1;34m13[0m:   doc.css([31m[1;31m"[0m[31m.roster-cards-container .student-card[1;31m"[0m[31m[0m).each [32mdo[0m |student|
    [1;34m14[0m:     stu = {[33m:name[0m => student.css([31m[1;31m"[0m[31m.card-text-container .student-name[1;31m"[0m[31m[0m).text,
    [1;34m15[0m:                  [33m:location[0m => student.css([31m[1;31m"[0m[31m.card-text-container .student-location[1;31m"[0m[31m[0m).text,
    [1;34m16[0m:                  [33m:profile_url[0m => student.children.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
    [1;34m17[0m:                }
    [1;34m18[0m:     students << stu
 => [1;34m19[0m:     binding.pry
    [1;34m20[0m:   [32mend[0m
    [1;34m21[0m: 
    [1;34m22[0m: 
    [1;34m23[0m:   [1;34m# => [[0m
    [1;34m24[0m:   [1;34m#        {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"},[0m
    [1;34m25[0m:   [1;34m#        {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"},[0m
    [1;34m26[0m:   [1;34m#        {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "students/carlos-rodriguez.html"},[0m
    [1;34m27[0m:   [1;34m#        {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "students/lorenzo-oro.html"},[0m
    [1;34m28[0m:   [1;34m#        {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "students/marisa-royer.html"}[0m
    [1;34m29[0m:   [1;34m#      ][0m
    [1;34m30[0m: [32mend[0m

