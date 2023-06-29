class HomeController < ApplicationController
  def index
  end

  def example
    render json: { message: 'Exemplo de resposta AJAX' }
  end
end
