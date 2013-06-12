# coding: utf-8
class UserMailer < ActionMailer::Base
  default from: "\"YoungLovers\" <info@younglovers.ru>"
  layout 'mailer'
  
  def welcome_email(user)
    @root_url = 'http://' + APP_CONFIG['default_host']
    @user = user
    mail(:to => user.email, :subject => "Добро пожаловить в магазин YoungLovers!")
  end
  
  def order_email(order)
    @root_url = 'http://' + APP_CONFIG['default_host']
    @order = order
    mail(:to => @order.address.email, :subject => "Вы сделали заказ в магазине YoungLovers!")
  end
  
  def order_paid_email(order)
    @root_url = 'http://' + APP_CONFIG['default_host']
    @yandex_marker_rul = Rails.configuration.yandex_market_raiting_page
    @order = order
    mail(:to => @order.address.email, :subject => "Спасибо за покупку!")
  end
end
