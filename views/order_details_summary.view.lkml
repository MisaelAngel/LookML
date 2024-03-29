view: order_details_summary {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: count {}
      column: sale_price {}
    }
  }
  dimension: order_id {
    type: number
  }
  dimension: count {
    type: number
  }
  dimension: sale_price {
    type: number
  }
}
