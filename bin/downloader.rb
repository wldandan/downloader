#!/usr/bin/env ruby

$: << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler/setup'
require 'thor'
require '../lib/downloader'

class Export < Thor

  desc 'products [filter]', 'Export products for default host'
  long_desc <<-LONGDESC
    `products` will export the products for the default host.

    You can optionally specify a filter, which will be a part of the query.

    For example: If the filter you specify is "Prod_UpdatedBy=1448", the query will be "select * from Product where Prod_UpdatedBy=1448"

    The command format should be as below:

    > $ ./exporter products "Prod_UpdatedBy=1448"

  LONGDESC
  def products(filter=nil)
    exporter = ProductExporter.new nil, nil, nil, filter
    exporter.export
  end

  desc 'products_for_specific_host [host] [user] [pass] [filter]', 'Export products for specific host'
  long_desc <<-LONGDESC
    `products_for_specific_host` will export the products for specific host.

    The host ip, username, password for database are required. and you can optionally specify a filter, which will be a part of the query.

    For example: If the filter you specify is "Prod_UpdatedBy=1448", the query will be "select * from Product where Prod_UpdatedBy=1448"

    The command format should be as below:

    > $ ./exporter products 10.41.7.213 username password "Prod_UpdatedBy=1448"

  LONGDESC
  def products_for_specific_host(host, user, pass, filter=nil)
    exporter = ProductExporter.new host, user, pass, filter
    exporter.export
  end
end

Export.start