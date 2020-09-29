with customers as (

    select * from {{ ref('customers') }}

),
     payments as (

    select * from {{ ref('order_payments') }}
),
     customer_payments as (

        select 
               customer_id, 
               sum(total_amount) as customer_total_amount, 
               sum(number_payments) as customer_number_of_payments
        from payments 
        group by 1
        
        ),

    final as (
        SELECT
            customers.customer_id,
            customers.first_name,
            customers.last_name,
            customers.first_order_date,
            customers.most_recent_order_date,
            customers.number_of_orders
        FROM
            customers
        
        left join customer_payments using (customer_id)
        
        )

    select * from final