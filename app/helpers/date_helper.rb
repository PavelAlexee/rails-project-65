module DateHelper
  def format_datetime(datetime)
    return '' unless datetime.present?
    datetime.strftime('%d.%m.%y %H:%M')
  end
end
