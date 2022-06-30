require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'pry'

browser = Watir::Browser.new
browser.goto 'https://mfrm.dispatchtrack.com/home?account_id=22&date_datepicker=05%2F31%2F2022&date=05%2F31%2F2022&mode=expanded&selected_tab=dashboard'
browser.text_field(:name => "email").set "037000@expressway.com"
browser.text_field(:name => "password").set "contractor1234"
browser.button(:name => "commit").click

dashboard_children = dashboard_container.to_html.children
# until browser.div(:id=>"some_div").exists? do sleep 1 end
# browser.div(:id => "container").wait_until_present
# browser.window(title: 'DispatchTrack')wait_until()
# Watir::Wait.until { Nokogiri::HTML(browser.html).css("div.container-fluid div.row div.col-md-12 div.p-lr-5 row.mb-5").exists?}

# browser.html(dashboard_children)exists?


doc = Nokogiri::HTML(browser.html)
routes_container = doc.css('div.container-fluid')
routes_row = routes_container.css('div.row')
routes_columns = routes_row.css('div.col-md-12')
dashboard_container = routes_columns.css('div.p-lr-5')
routes_table = dashboard_container.css('row.mb-5')

binding.pry
# parsed_page.css('schedules-container order cursor').each do |order|
#   puts order.content
# end

File.open("parsed.txt", "w") { |f| f.write "#{routes_table}" }

browser.close
