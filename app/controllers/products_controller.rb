class ProductsController < ApplicationController

  def index
    products = Product.all
    render json: {products: products}, status: :ok
  end

  def create
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
    else
      product = Product.find(params[:id])
    end

    if product.save
      render json: {product: product}, status: :created
    else
      render json: {errors: product.errors}, status: :unprocessable_entity
    end

  end

  def show
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
    else
      product = Product.find(params[:id])
    end
    render json: {product: product}, status: :ok
  end

  def update
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
    else
      product = Product.find(params[:id])
    end

    if product.update(product_params)
      render json: {product: product}, status: :ok
    else
      render json: {errors: product.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
      product = nil
      head 204
    else
      product = Product.find(params[:id])
      product.destroy
    end
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :amount, :price)
  end

end