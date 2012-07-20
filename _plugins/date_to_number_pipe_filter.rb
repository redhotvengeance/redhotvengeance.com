module Jekyll
  module DateToNumberPipeFilter
    def date_to_number_pipe(input)
      input.strftime("%m|%d|%y")
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateToNumberPipeFilter)