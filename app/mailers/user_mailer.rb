# coding: utf-8
class UserMailer < ActionMailer::Base
  default from: "info@younglovers.ru"
  
  def welcome_email(user)
    @user = user
    @url  = "http://younglovers.ru/"
    mail(:to => user.email, :subject => "Добро пожаловить в магазин YoungLovers!")
  end
  
  def order_email(order)
    @order = order
    @url  = "http://younglovers.ru/"
    mail(:to => @order.address.email, :subject => "Вы сделали заказ в магазине YoungLovers!")
  end
end
