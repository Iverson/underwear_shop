function price(item)
{
	return item['attrs']['price']*(100 - Math.max(item['attrs']['promo_discount'], item['attrs']['discount']))/100
}