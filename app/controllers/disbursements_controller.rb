class DisbursementsController < ApplicationController
  def index
    disbursements = Disbursement.eager_load(:orders).where(date: params[:date])
    if params[:merchant_id]
      disbursements = disbursements.where(merchant_id: params[:merchant_id])
    end
    render json: disbursements.as_json(includes: :orders)
  end
end
