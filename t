
[1mFrom:[0m /home/keith-94593/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 37 Scraper.scrape_profile_page:

    [1;34m25[0m:   [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m26[0m:     html = open(profile_url)
    [1;34m27[0m:     doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m28[0m:     student = {}
    [1;34m29[0m:     link_array = []
    [1;34m30[0m:     social_media_array = []
    [1;34m31[0m: 
    [1;34m32[0m:     doc.css([31m[1;31m"[0m[31mdiv.vitals-container div.social-icon-container a[1;31m"[0m[31m[0m).each [32mdo[0m |social_media|
    [1;34m33[0m:       link = social_media.attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
    [1;34m34[0m:       [32mif[0m link.include? [31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m
    [1;34m35[0m:         [1;34m#social_media_array << :twitter[0m
    [1;34m36[0m:       [32mend[0m
 => [1;34m37[0m: binding.pry
    [1;34m38[0m:       link_array << link
    [1;34m39[0m: 
    [1;34m40[0m:     [32mend[0m
    [1;34m41[0m: 
    [1;34m42[0m:     student = {
    [1;34m43[0m:       [33m:linkedin[0m => link_array[[1;34m1[0m],
    [1;34m44[0m:       [33m:github[0m => link_array[[1;34m2[0m]
    [1;34m45[0m:     }
    [1;34m46[0m: 
    [1;34m47[0m:     student
    [1;34m48[0m: 
    [1;34m49[0m:   [32mend[0m

