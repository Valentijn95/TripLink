module ApplicationHelper

  def country_to_flag(country_name)
    country = ISO3166::Country.find_country_by_any_name(country_name)
    return unless country
    country_code = country.alpha2
    country_code.codepoints.map { |c| (c + 127397).chr(Encoding::UTF_8) }.join
  end

end
