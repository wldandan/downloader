require 'nokogiri'
require 'open-uri'
require 'json'
require 'httpclient'

module Downloader
  class ITPub
    ROOT_URL = 'http://www.itpub.net/'
    LOGIN_RELATIVE_URL = 'member.php?mod=logging&action=login&loginsubmit=yes&infloat=yes&lssubmit=yes'

    def execute(download_url)
      login

      document = Nokogiri::HTML(@client.get(download_url).content)
      document.css(css_selector).each do |item|
        download(item['href'], item.inner_text) if is_in_download_list?(item.inner_text)
      end
    end

    private

    def is_in_download_list?(title)
      unless title.empty?
        ext = title[title.rindex('.')..-1]
        ['.pdf','.rar','.zip','.tar','.epub'].include?(ext)
      end
    end

    def login
      body = { 'username' => 'wldandan', 'password' => '1981119', 'cookietime' => '259200' }
      client.post("#{ROOT_URL}#{LOGIN_RELATIVE_URL}", body).content
    end

    def client
      @client ||= HTTPClient.new
    end

    def download(relative_url, title)
      url="#{ROOT_URL}#{relative_url}"
      url.gsub!('attachment.php?', 'forum.php?mod=attachment&')
      system "curl --cookie /tmp/cookie -o '#{title}' '#{url}'"
    end

    def css_selector
      "ignore_js_op a"
    end
  end
end
