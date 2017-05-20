class ExpensesController < ApplicationController
  def index
    @expenses = Transaction.expense_for_user
  end

  def show
    @expense = Transaction.find(params[:format])
  end

  def new
    @expense = Transaction.new
  end

  def create
  end

  def edit
    @expense = Transaction.find(params[:format])
  end

  def update
  end
end
