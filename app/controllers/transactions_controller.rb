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

  def new2
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(income_expense_params)
    respond_to do |format|
    if params[:transaction][:transactionable_type] == "income"
       @transaction.transactionable_type = params[:transaction][:transactionable_type]
       if @transaction.save
        format.html { redirect_to incomes_show_path(@transaction), notice: "The income has been successfully created."}
        # format.json { render json: show, :status => :created, location: @contacts}
        # redirect_to incomes_show_path(@transaction), notice: "The income has been successfully created."
      else
        format.html { render action: 'new'}
        format.json { render json: @contact.errors, :status => :unprocessable_entity}
       end
    else
       @transaction.transactionable_type = params[:transaction][:transactionable_type]
       if @transaction.save
        format.html { redirect_to expenses_show_path(@transaction), notice: "The expense has been successfully created."}
       else
        format.html { render action: 'new2'}
        format.json { render json: @contact.errors, :status => :unprocessable_entity}
       end
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
    extract_reports
    respond_to do |format|
      format.html
      format.js
    end
  end

  def download_pdf
    @reports = extract_reports if !extract_reports.nil?
    respond_to do |format|
      format.html
      format.pdf do
        # render :pdf => "transactions/download_pdf" # change layout which format u want
          pdf = Prawn::Document.new
          table_data = Array.new
          table_data << ["Type Of Income", "Amount", "Date", "Credit/Debit"]
          if !@reports.nil?
          @reports.each do |i|
            if i.transactionable_type == "income"
              type = "Credit"
            else
              type = "Debit"
            end
            table_data << [i.type_of_income_and_expense, i.amount, i.enter_date, type ]
          end
          end
          pdf.table(table_data, :width => 500, :cell_style => { :inline_format => true })
          send_data pdf.render, filename: 'test.pdf', type: 'application/pdf', :disposition => 'inline'
      end
    end
  end

  def download_csv
    @transactions = extract_reports if !extract_reports.nil?
    if !@transactions.nil?
    respond_to do |format|
    format.html
      # format.csv { render text: @reports.to_csv } if !@reports.nil?
        format.csv { send_data @transactions.to_csv, filename: "transaction-#{Date.today}.csv" }
      end
    end

  end

private
  def income_expense_params
    params.require(:transaction).permit!
  end

  def extract_reports
    @reports = Transaction.report_search_new(params[:start_date], params[:end_date])
  end
end
