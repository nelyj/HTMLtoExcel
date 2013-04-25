require 'nokogiri'
require 'open-uri'

url = "http://localhost/pasaportes.html"
data = Nokogiri::HTML(open(url))


rows = data.xpath("/html/body/div[3]/div[2]/table/tbody/tr")
#outFile = File.new("ruby.txt", "w")

details = rows.collect do |row|
	detail = {}
	[
	 [:participant_name, 'td[1]/text()'],
	 [:entry_name, 'td[2]/text()'],
	 [:name_file, 'td[3]/a/text()'],
	 [:download, 'td[3]/a/@href']
	].each do |name, xpath|
	 detail[name] = row.at_xpath(xpath).to_s.strip
	end
	detail
end
puts details
#outFile.puts(objeto)
#outFile.close

