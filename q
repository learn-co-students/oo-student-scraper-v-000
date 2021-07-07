
[1mFrom:[0m /home/iamdavidmichaelmoore/oo-student-scraper-v-000/lib/scraper.rb @ line 32 Scraper.scrape_profile_page:

    [1;34m20[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m21[0m:   keys = [[33m:twitter[0m, [33m:linkedin[0m, [33m:github[0m,[33m:blog[0m]
    [1;34m22[0m:   doc = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m23[0m:   urls = doc.css([31m[1;31m"[0m[31m.social-icon-container a[1;31m"[0m[31m[0m)
    [1;34m24[0m:   student = urls.each_with_object({}) [32mdo[0m |link, hash|
    [1;34m25[0m:     keys.detect [32mdo[0m |key_name|
    [1;34m26[0m:       key_name ==
    [1;34m27[0m:       link[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].gsub([35m[1;35m/[0m[35m^https?[1;35m\:[0m[35m[1;35m\/[0m[35m[1;35m\/[0m[35m|^?www?.[1;35m/[0m[35m[0m,[31m[1;31m"[0m[31m[1;31m"[0m[31m[0m).split([31m[1;31m'[0m[31m.[1;31m'[0m[31m[0m)[[1;34m0[0m]
    [1;34m28[0m:         hash[key_name] = link[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m29[0m:         [1;34m# binding.pry[0m
    [1;34m30[0m:     [32mend[0m
    [1;34m31[0m:   [32mend[0m
 => [1;34m32[0m:   binding.pry
    [1;34m33[0m:   [1;34m# urls.each_with do |url|[0m
    [1;34m34[0m:   [1;34m#   link = url["href"][0m
    [1;34m35[0m:   [1;34m#   hash.detect do |k,v|[0m
    [1;34m36[0m:   [1;34m#     binding.pry[0m
    [1;34m37[0m:   [1;34m#     k.to_s == link.gsub(/^https?\:\/\/|^?www?./,"").split(".")[0][0m
    [1;34m38[0m:   [1;34m#     hash[k] = link[0m
    [1;34m39[0m:   [1;34m#   end[0m
    [1;34m40[0m:   [1;34m# end[0m
    [1;34m41[0m:   student[[33m:profile_quote[0m] = doc.css([31m[1;31m"[0m[31m.vitals-text-container div.profile-quote[1;31m"[0m[31m[0m).text
    [1;34m42[0m:   student[[33m:bio[0m] = doc.css([31m[1;31m"[0m[31m.details-container .description-holder p[1;31m"[0m[31m[0m).text
    [1;34m43[0m:   [1;34m# h.delete_if {|k,v| v == ""}[0m
    [1;34m44[0m:   student
    [1;34m45[0m: [32mend[0m

