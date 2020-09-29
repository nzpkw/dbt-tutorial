with orders as (

    select * from {{ ref('stg_orders') }}

),
     payments as (

    select * from {{ ref('stg_payments') }}
),
     order_payments as (

        select order_id,
                sum(amount) as total_amount,
                count(payment_id) as number_payments

        from payments

        group by 1 

     ),

    final as (
        select orders.order_id,
               orders.customer_id,
               orders.order_date,
               order_payments.total_amount,
               order_payments.number_payments
        from orders

        left join order_payments using (order_id)
    )

    select * from final