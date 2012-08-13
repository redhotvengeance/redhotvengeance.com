module Jekyll

  class YouTubeTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @id = nil
      regex_id = Regexp.new(/id:\w+/i)
      @id = regex_id.match(markup).to_s.gsub("id:", "")

      super
    end

    def render(context)
      "<figure class='video'><div class='video-wrapper'><iframe src='http://www.youtube.com/embed/#{@id}' width='480' height='360'>youtube</iframe></div></figure>"
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::YouTubeTag)
