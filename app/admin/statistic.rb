# encoding: utf-8
ActiveAdmin.register_page "Statistics" do
  menu :priority => 100, :label => proc{ I18n.t("active_admin.statistics") }
  
  content do
    para "Статистика"
    
    start_date = Order.order(:created_at).first.created_at
    end_date = Date.current
    
    if params[:from_date] && params[:to_date]
      from_date = Date.parse(params[:from_date])
      to_date = Date.parse(params[:to_date])
    else
      show_all = true
      from_date = start_date
      to_date = end_date
    end
    
    orders = Order.where(:order_state_id => 5, :created_at => from_date..to_date).order(:id)
    
    month_html = ""
    
    (start_date.year..end_date.year).each do |y|
       mo_start = (start_date.year == y) ? start_date.month : 1
       mo_end = (end_date.year == y) ? end_date.month : 12

       (mo_start..mo_end).each do |m|
          if y == from_date.year && m == from_date.month && !show_all
            month_html += "<b>#{Date::MONTHNAMES[m]}</b>"
          else
            month_html += link_to Date::MONTHNAMES[m], "?from_date=#{Date.new(y, m).strftime("%Y-%m-%d")}&to_date=#{(Date.new(y, m)+ 1.month).strftime("%Y-%m-%d")}"
          end
           
           month_html += "&nbsp;&nbsp;&nbsp;"
       end
    end
    
    para month_html.html_safe
    
    table_for orders do |f|
      f.column :id
      f.column "User" do |o|
        link_to o.address.fio, admin_order_path(o)
      end
      f.column "Date" do |o|
        o.created_at.strftime("%d-%b")
      end
      f.column "Summ (RUR)" do |o|
        o.summ
      end
      
    end
    
    total = orders.joins(:order_items).sum(:price)
    purchaise_total = orders.joins(:order_items => :product).sum(:purchaise_price)
    
    panel "Итого" do
      para "<b>Оборот:</b> #{total.to_i}".html_safe
      para "<b>Закупочная цена:</b> #{purchaise_total.to_i}".html_safe
      para "<b>Прибыль:</b> #{total.to_i - purchaise_total.to_i}".html_safe
    end
    
  end
end