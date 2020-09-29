SELECT
    id as payment_id,
    order_id,
    payment_method,
    amount
FROM
    data_source.payments