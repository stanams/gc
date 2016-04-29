class RedemptionCard < ActiveRecord::Base

  validates :card_code, :card_pin, presence: true
  validates :card_code, uniqueness: true
  validates :card_code, length: { is: 16 }
  validates :card_pin, length: { is: 4 }

  belongs_to :user

  def self.use!(user, code, pin)
    redemption_card = RedemptionCard.where(used_at: nil, card_code: code, card_pin: pin).first
    if redemption_card
      redemption_card.update! used_at: Time.now, user: user
      user.update! balance: user.balance + redemption_card.amount
      redemption_card
    else
      nil
    end
  end

end
