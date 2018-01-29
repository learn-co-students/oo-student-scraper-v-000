
[1mFrom:[0m /home/readmusik-110568/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 47 Scraper.scrape_profile_page:

    [1;34m27[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m28[0m:   html = open(profile_url)
    [1;34m29[0m:   doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m30[0m:   student_hash = {}
    [1;34m31[0m:   name = doc.css([31m[1;31m"[0m[31m.profile-name[1;31m"[0m[31m[0m).text.downcase.split.join
    [1;34m32[0m:   anchors = doc.css([31m[1;31m"[0m[31m.social-icon-container a[1;31m"[0m[31m[0m)
    [1;34m33[0m:   anchors.each [32mdo[0m |a|
    [1;34m34[0m:     [32mif[0m a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m)
    [1;34m35[0m:       student_hash[[33m:twitter[0m]= a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m36[0m:     [32melsif[0m a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m)
    [1;34m37[0m:       student_hash[[33m:linkedin[0m]= a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m38[0m:     [32melsif[0m a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m)
    [1;34m39[0m:       student_hash[[33m:github[0m]= a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m40[0m:     [32melsif[0m a.css([31m[1;31m"[0m[31mimg[1;31m"[0m[31m[0m).attribute([31m[1;31m"[0m[31msrc[1;31m"[0m[31m[0m).value.include?([31m[1;31m"[0m[31mrss[1;31m"[0m[31m[0m)
    [1;34m41[0m:       student_hash[[33m:blog[0m]= a[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m42[0m:     [32mend[0m
    [1;34m43[0m:   [32mend[0m
    [1;34m44[0m:   student_hash[[33m:profile_quote[0m]= doc.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text
    [1;34m45[0m:   student_hash[[33m:bio[0m]= doc.css([31m[1;31m"[0m[31m.description-holder p[1;31m"[0m[31m[0m).text
    [1;34m46[0m: 
 => [1;34m47[0m:   binding.pry
    [1;34m48[0m: 
    [1;34m49[0m:   student_hash
    [1;34m50[0m: 
    [1;34m51[0m: 
    [1;34m52[0m: [32mend[0m

