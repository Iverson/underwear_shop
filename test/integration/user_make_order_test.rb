require 'test_helper'

class UserMakeOrderTest < ActionDispatch::IntegrationTest
  fixtures :sections
  fixtures :product_instances
  fixtures :products
  fixtures :pictures
  fixtures :order_states
  fixtures :deliveries
  
  test "User add product to cart and make order" do
    
    get "/"
    
    assert_response :success
    assert_template "index"
    assert_equal     session[:cart]['count'], 0
    
    product_instance = product_instances(:first)
    
    xml_http_request :post, 'cart/add.json', instance: product_instance.id
    assert_response  :success
    assert_equal      session[:cart]['count'], 1
    assert_equal      session[:cart]['summ'], product_instance.product.price

    get "order/checkout"
    assert_response :success
    assert_template "_step2"
    
    post_via_redirect "/orders", order: { address_attributes: {
                                            fio: "Hank",
                                            phone: "9260001467",
                                            email: "moody@gmail.com"
                                          },
                                          delivery_id: 1
                                        }
    assert_response :success
    assert_template "_step4"
    
    created_order = Order.find(session[:cart]['order_id'])
    
    assert_equal "Hank", created_order.address.fio
    
    post_via_redirect "/order/confirm", order: { order_state_id: 2 }
    last_mail = ActionMailer::Base.deliveries.last
    
    assert_response :success
    assert_template "index"
    assert_equal     ["moody@gmail.com"], last_mail.to
    assert_equal     0, session[:cart]['count']
    
    
  end
  
end