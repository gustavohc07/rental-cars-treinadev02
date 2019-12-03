module ApplicationHelper
  def cnpj_format(cnpj)
    cnpj_array = cnpj.split('')
    cnpj_array[1] << '.'
    cnpj_array[4] << '.'
    cnpj_array[7] << '/'
    cnpj_array[11] << '-'
    cnpj_array.join
  end

  def cpf_format(cpf)
    cpf_array = cpf.split('')
    cpf_array[2] << '.'
    cpf_array[5] << '.'
    cpf_array[8] << '-'
    cpf_array.join
  end
end
