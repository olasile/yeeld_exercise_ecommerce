class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy]

  def index
    set_products
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params)

    if @product.save
      redirect_to products_path, flash: { success: 'Product successfully created' }
    else
      flash.now[:errors] = @product.errors.full_messages
      render_flash
    end
  end

  def destroy
    raise(StandardError, 'There are orders attached to this product and it cannot be deleted') if Order.where(product_id: @product.id).exists?
    @product.destroy
    redirect_to products_path, flash: { success: 'Product successfully deleted.' }
  end

  private

  def set_products
    @products = Product.all
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def permitted_params
    params.require(:product).permit(:name, :price)
  end
end