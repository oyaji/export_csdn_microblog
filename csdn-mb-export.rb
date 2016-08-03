require 'open-uri'

# csdn's target webpage define
# oyaji
# url = 'http://hi.csdn.net/space-3360237-do-doing-view-me.html'
# xixi
url = 'http://hi.csdn.net/space-5625-do-doing-view-me.html'

pagenameprefix = 'http://hi.csdn.net/space-5625-do-doing-view-me-page-'
pagenamepostfix = '.html'

# function define
def restrict(html,starting_regexp,stopping_regexp)
  start = html.index(starting_regexp)
  stop = html.index(stopping_regexp,start) -1
  html[start..stop]
end

# output file manipulate
outputfilename = 'D:\csdnmbexport\outputcsdnmb.html'
outputfile = File.open(outputfilename,'a')

firstpage = open(url)

# get page count from the first page
firstpagetext = firstpage.read
puts firstpagetext
pagenumarr = firstpagetext.scan(%r{space-5625-do-doing-view-me-page-(\d+).html})
puts pagenumarr
puts pagenumarr.flatten.last.to_s.to_i
# loop in page count
for i in 1..pagenumarr.flatten.last.to_s.to_i
  puts i
  currentpageindex = pagenameprefix + i.to_s + pagenamepostfix

  currentpage = open(currentpageindex)
  currentpagetext = currentpage.read;nil
  # output to file
  outputfile << '<div class="pageindex">   page index : ' + i.to_s + '</div>'
  outputfile << restrict(currentpagetext,'<div class="doing_list">','<div class="page">')

end
outputfile << '</body>'
outputfile << '</html>'
outputfile.close
