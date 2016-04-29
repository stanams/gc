class RedemptionCardsController < ApplicationController

  def new
    @redemption_card = RedemptionCard.new(user_id: current_user.id)
  end

  def index
    @redemption_cards = RedemptionCard.all
  end

  def create
    @redemption_card = RedemptionCard.create(redemption_card_params)

    @current_user_balance = current_user.balance
    @current_user_balance += 20
    if (params[:redemption_card][:card_code].to_s.include?("symphonycrocks")) &&
      (params[:redemption_card][:card_pin] == "1234")


      redirect_to redemption_card_url(@redemption_card.id)
      flash.now[:success] = ["Congrats! You've redeemed your Card Gift!"]
    else
      flash.now[:errors] = ["Wrong code & pin combination!"]
      flash.now[:errors] += ["Please retry or contact our support."]
      render :new
    end
  end

  def show
    current_user.balance += 20
    @redemption_card = RedemptionCard.find(params[:id])
  end

  def check_form
    @last_used_redemption_cards = RedemptionCard.where.not(used_at: nil).order('used_at DESC').limit(4)
  end

  def check
    @redemption_card = RedemptionCard.use!(
      current_user,
      params[:redemption_card][:card_code],
      params[:redemption_card][:card_pin]
    )

    if @redemption_card.nil?
      flash[:errors] = ["Wrong code & pin combination!"]
      redirect_to check_form_redemption_cards_path
    end
  end

  private
  def redemption_card_params
    params.require(:redemption_card).permit(:card_code, :card_pin)
  end

end
