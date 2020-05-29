class ProductsController < ApplicationController

  def buy
  end
  
  def show
  end

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def new
  end
end
