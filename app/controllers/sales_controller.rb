class SalesController < ApplicationController
  
  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.total = @sale.value - (@sale.value * @sale.discount / 100)
    
    if @sale.tax == 1 #checkbox seleccionado
      @impuesto = 1
    else
      @impuesto = 1.19
    end
    @sale.total = @sale.total * @impuesto
    
    if @sale.save
      redirect_to sales_done_path
    else
      redirect_to sales_new_path, notice:'ERROR'
    end

  end

  def done
    @sales = Sale.all
  end

  private
  def sale_params
    params.require(:sale).permit(:code, :detail, :category, :value, :discount, :tax)
  end

end
