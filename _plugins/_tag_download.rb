module Jekyll
  class DownloadButtonTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      #matches = /\[([^\]]+)\]\((.*)\)\{([^\}]+)\}/.match(text)
      #@text = "[#{matches[1]}](#{matches[2]}){: class='btn btn-primary btn-medium' onclick=\"recordOutboundLink(this, 'Archive', 'Download', '#{matches[3]}');return false;\"}"
      @text = "{:class='btn btn-primary btn-medium' onclick=\"recordOutboundLink(this, 'Archive', 'Download', '#{text}');return false;\"}"
    end

    def render(context)
    	"#{@text}"
      # "<a href='#{@matches[1]}' class='btn btn-primary btn-medium' onclick=\"recordOutboundLink(this, '$cat', '$action', '$label');return false;\">#{@matches[2]}</a>"
    end
  end
end

Liquid::Template.register_tag('download_button', Jekyll::DownloadButtonTag)