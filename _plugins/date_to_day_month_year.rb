module Jekyll
  module DateToDayMonthYearPipeFilter
    def date_to_day_month_year(input)
      input.strftime("%A, %B %d, %Y")
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateToDayMonthYearPipeFilter)
