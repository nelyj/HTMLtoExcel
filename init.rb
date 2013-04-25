require 'nokogiri'
require 'open-uri'
require 'simple_xlsx'

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

SimpleXlsx::Serializer.new("HTMLtoExcel.xlsx") do |document|
 document.add_sheet("Sheet1") do |sheet|
  sheet.add_row(["Participant Name", "Entry Name","File Name", "URL Download"])
  details.each do |row|
   sheet.add_row([row[:participant_name]])
  end

 end
end
#outFile.puts(objeto)
#outFile.close

