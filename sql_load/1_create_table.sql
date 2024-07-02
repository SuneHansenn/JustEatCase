-- Create table for JustEat case data
CREATE TABLE public.JustEatCase (
    "customer_id" VARCHAR(32),
    "customer_segment" TEXT,
    "order_id" VARCHAR(32),
    "order_date" DATE,
    "customer_nth_order" INT,
    "order_status_type" TEXT,
    "order_uses_new_service" TEXT,
    "order_food_price" NUMERIC(10, 2),
    "order_delivery_price" NUMERIC(10, 2),
    "gross_order_value" NUMERIC(10, 2),
    "pct_commission_on_gross_order_value" INT,
    "restaurant_id" TEXT,
    "restaurant_cuisine" VARCHAR(32),
    "delivery_times_seconds" INT,
    "courier_id" INT
);

-- Set ownership of tables
ALTER TABLE public.JustEatCase OWNER TO postgres;