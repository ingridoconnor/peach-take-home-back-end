class TransactionsController < ApplicationController
  def index
    render json: Transaction.all
  end

  def update
    transaction = Transaction.find(params[:id])
    transaction.update(transaction_params)
    # transaction.update(category_id: params[:transaction][:category][:id])
    render json: transaction
  end

  def mark_as_reviewed
    transaction = Transaction.find(params[:id])
    transaction.mark_as_reviewed
    render json: transaction
  end

  def update_category
    puts params[:category]
    transaction = Transaction.find(params[:id])
    transaction.update(category: params[:category])
    render json: transaction
  end

  def needs_review
    transactions = Transaction.where(reviewed: [false, nil])
    render json: transactions
  end

  private

  def transaction_params
    params.require(:transaction).permit(:category_id, :reviewed)
  end
end
