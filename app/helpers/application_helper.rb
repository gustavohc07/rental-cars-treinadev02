module ApplicationHelper
  def cnpj_format(cnpj)
    cnpj_array = cnpj.split('')
    cnpj_array[1] << '.'
    cnpj_array[4] << '.'
    cnpj_array[7] << '/'
    cnpj_array[11] << '-'
    cnpj_array.join
  end
end
