
[1mFrom:[0m /home/lennhy/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 24 Scraper.scrape_index_page:

     [1;34m7[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_index_page[0m(index_url)
     [1;34m8[0m:   [1;34m# stores the HTML of the URL into a variable called html[0m
     [1;34m9[0m:   html = open([31m[1;31m"[0m[31mhttp://159.203.117.55:3537/fixtures/student-site/[1;31m"[0m[31m[0m)
    [1;34m10[0m:   [1;34m# take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")[0m
    [1;34m11[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m12[0m:  [1;34m# selector will allow us to grab index page that lists all of the students[0m
    [1;34m13[0m:   student_profile=[]
    [1;34m14[0m:   hash = {}
    [1;34m15[0m:   index = doc.css([31m[1;31m"[0m[31mdiv.roster-cards-container[1;31m"[0m[31m[0m).each [32mdo[0m |student|
    [1;34m16[0m:     student.css([31m[1;31m"[0m[31mdiv.student_card a[1;31m"[0m[31m[0m).each [32mdo[0m |student_detail|
    [1;34m17[0m:        hash[[33m:name[0m] = student_detail.css([31m[1;31m"[0m[31mh4.student-name[1;31m"[0m[31m[0m).text
    [1;34m18[0m:        hash[[33m:location[0m] = student_detail.css([31m[1;31m"[0m[31mp.student-location[1;31m"[0m[31m[0m).text
    [1;34m19[0m:        hash[[33m:profile_url[0m] = student_detail.css([31m[1;31m"[0m[31mdiv.student-card a[1;31m"[0m[31m[0m).attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
    [1;34m20[0m:        student_profile << hash
    [1;34m21[0m:       [1;34m#  student_profile << {name: name_string, location: location_string, profile_url: profile_url_string}[0m
    [1;34m22[0m:     [32mend[0m
    [1;34m23[0m:   [32mend[0m
 => [1;34m24[0m:   binding.pry
    [1;34m25[0m: 
    [1;34m26[0m:     student_profile
    [1;34m27[0m: [32mend[0m

