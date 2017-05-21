class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(income_expense_params)
    if params[:transaction][:transactionable_type] == "income"
       @transaction.transactionable_type = params[:transaction][:transactionable_type]
       if @transaction.save
        redirect_to incomes_show_path(@transaction), notice: "The income has been successfully created."
       end
    else
       @transaction.transactionable_type = params[:transaction][:transactionable_type]
       if @transaction.save
        redirect_to expenses_show_path(@transaction), notice: "The expense has been successfully created."
       end
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(income_expense_params)
    if @transaction.transactionable_type == "income"
      redirect_to incomes_index_path, notice: "The income has been updated"
    else
      redirect_to expenses_index_path, notice: "The expense has been updated"
    end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    if @transaction.destroy
      if @transaction.transactionable_type == "expense"
        redirect_to expenses_index_path, notice: "The expense has been deleted"
      else
        redirect_to incomes_index_path, notice: "The income has been updated"
      end
    end
  end

  def report
  	# @reports = Transaction.report_search(params[:start_date], params[:end_date])
   #  respond_to do |format|
   #    format.html
   #    format.js
  end

  def report_search
    @reports = Transaction.report_search(params[:start_date], params[:end_date])
    respond_to do |format|
      format.html
      format.js
    end

  end

private
  def income_expense_params
    params.require(:transaction).permit!
  end
end
