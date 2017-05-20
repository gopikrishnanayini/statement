class IncomesController < ApplicationController
  def index
    @incomes = Transaction.income_for_user
  end

  def show
    @income = Transaction.find(params[:format])
  end

  def new
    @income = Transaction.new
  end


  def edit
    @income = Transaction.find(params[:format])
  end


  def destroy
    @income = Transaction.find(params[:id])
    @income.destroy
  end
private
  def income_params
    params.require(:transaction).permit!
  end
end
