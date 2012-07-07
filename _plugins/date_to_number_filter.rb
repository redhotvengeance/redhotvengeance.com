module Jekyll
  module DateToNumberFilter
    def date_to_number(input)
      input.strftime("%m%d%y")
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateToNumberFilter)