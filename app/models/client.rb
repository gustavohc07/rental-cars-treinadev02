class Client < ApplicationRecord


  def description
    "#{name} - #{cpf}"
  end
end
