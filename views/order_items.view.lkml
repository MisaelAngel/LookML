view: order_items {
  sql_table_name: public.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: shipping_days {
    type: duration_day
    sql_start: ${returned_date} ;;
    sql_end: '2017-03-20' ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: percentage_sales_not_email_source {
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_sales_not_email_users}
      / NULLIF(${total_sales}, 0) ;;
  }

  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: total_sales_not_email_users {
    type: sum
    sql: ${sale_price} ;;
    filters: [users.is_email_source: "No"]
  }
}
