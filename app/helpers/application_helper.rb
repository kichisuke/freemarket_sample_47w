module ApplicationHelper
  def card_brand(card_brand)
    case card_brand
    when "Visa"
      image_tag 'credit_card/visa.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    when "MasterCard"
      image_tag 'credit_card/master_card.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    when "Saison Card"
      image_tag 'credit_card/saison_card.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    when "JCB"
      image_tag 'credit_card/jcb.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    when "American Express"
      image_tag 'credit_card/american_express.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    when "Diners Club"
      image_tag 'credit_card/diners_club.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    when "Discover"
      image_tag 'credit_card/discover.png', alt: 'credit_card', class: 'registration-form__credit-img__size'
    end 
  end
end
