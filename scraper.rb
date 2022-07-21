require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'pry'

browser = Watir::Browser.new
browser.goto 'https://mfrm.dispatchtrack.com/home?account_id=22&date_datepicker=05%2F31%2F2022&date=05%2F31%2F2022&mode=expanded&selected_tab=dashboard'
browser.text_field(:name => "email").set "037000@expressway.com"
browser.text_field(:name => "password").set "contractor1234"
browser.button(:name => "commit").click

#browser.table(id: 'service_units').wait_until_present


#dashboard_children = dashboard_container.to_html.children
# until browser.div(:id=>"some_div").exists? do sleep 1 end
# browser.div(:id => "container").wait_until_present
# browser.window(title: 'DispatchTrack')wait_until()
# Watir::Wait.until { Nokogiri::HTML(browser.html).css("div.container-fluid div.row div.col-md-12 div.p-lr-5 row.mb-5").exists?}

# browser.html(dashboard_children)exists?

binding.pry
js_doc = browser.table(id: 'service_units').wait_until(&:present?) && browser.td(class: 'unit_table').wait_until(&:present?)
# browser.div(class: 'home_order_list').wait_until(&:present?)
new_doc = Nokogiri::HTML(js_doc.inner_html)
#route = Array.new
binding.pry
routes = browser.td(class: ['unit_table'])
stops = new_doc.css('table.order.cursor')
driver_route = Array.new
binding.pry

#div[cssAttribute=cssValue]

stops.each do |stop|
  delivery = {
    customer_name: stop.css('strong.customer_name').text,
    zipcode: stop.css('td[colspan*="3"]').text[-5..-1],
    date: stop.css('td[style*="text-align:right;"]').text,

    # stop[:delivery_type] = ("Delivery" if stop.css('td[colspan*="4"]').text.match(/^([\w\-]+)/).to_s == "delivery"),
    # stop[:delivery_type] = ("Tier 1" if stop.css('td[colspan*="4"]').text[0,5] == "Tier 1"),
    # stop[:delivery_type] = ("Tier 2" if stop.css('td[colspan*="4"]').text[0,5] == "Tier 2"),
    # if stop.css('td[colspan*="4"]').text.match(/^([\w\-]+)/).to_s == "delivery"
    #   delivery_type: "Delivery",
    # else
    #   delivery_type: stop.css('td[colspan*="4"]').text[0,5]
    # end
  }
  delivery[:status] = ("Finished" if stop.css('span[data-status*="Finished"]').text == "Finished") || ("Unable to Start" if stop.css('span[data-status*="Unable to Start"]').text == "Unable to Start") || ("Canceled" if stop.css('span[data-status*="Canceled"]').text == "Canceled") || ("Unable to Finish" if stop.css('span[data-status*="Unable to Start"]').text == "Unable to Finish")
  delivery[:type] = ("Delivery" if stop.css('td[colspan*="4"]').text.match(/^([\w\-]+)/).to_s == "Delivery") || ("Tier 1" if stop.css('td[colspan*="4"]').text[0,6] == "Tier 1") || ("Tier 2" if stop.css('td[colspan*="4"]').text[0,6] == "Tier 2")
  # delivery[:type] = ("Tier 1" if stop.css('td[colspan*="4"]').text[0,6] == "Tier 1")
  # delivery[:type] = ("Tier 2" if stop.css('td[colspan*="4"]').text[0,6] == "Tier 2")
  binding.pry
  driver_route << stop
end

binding.pry

#.match(/^([\w\-]+)/)

# routes_container = doc.css('div.container-fluid')
# routes_row = routes_container.css('div.row')
# routes_columns = routes_row.css('div.col-md-12')
# dashboard_container = routes_columns.css('div.p-lr-5')
# routes_table = dashboard_container.css('row.mb-5')

#binding.pry
# parsed_page.css('schedules-container order cursor').each do |order|
#   puts order.content
# end

File.open("parsed.txt", "w") { |f| f.write "#{new_doc}" }

browser.close
