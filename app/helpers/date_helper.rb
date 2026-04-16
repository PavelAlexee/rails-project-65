# frozen_string_literal: true

module DateHelper
  def format_datetime(datetime)
    return '' if datetime.blank?

    datetime.strftime('%d.%m.%y %H:%M')
  end
end
