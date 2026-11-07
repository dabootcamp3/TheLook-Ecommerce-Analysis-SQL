-- Berapa jumlah order yang tercatat?
SELECT COUNT(*) jumlah_order
FROM bigquery-public-data.thelook_ecommerce.orders;

-- Berapa jumlah item yang dibeli?
SELECT COUNT(*) jumlah_item
FROM bigquery-public-data.thelook_ecommerce.order_items;

-- Berapa jumlah order untuk masing-masing status?
SELECT status, COUNT(*) as jumlah_order
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status;

-- Apa saja 10 produk terlaris berdasarkan jumlah order?
SELECT product_id, COUNT(*) item_cnt
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY product_id
ORDER BY 2 DESC
LIMIT 10;

-- Berapa jumlah customer untuk masing-masing negara?
SELECT 
  country,
  COUNT(*) jumlah_cust
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Bagaimana performa masing-masing status jumlah item, jumlah order, total sales, rata-rata sale price
SELECT 
  status,
  COUNT(*) jumlah_item,
  COUNT(DISTINCT order_id) jumlah_order,
  ROUND(SUM(sale_price), 1) total_sales,
  ROUND(AVG(sale_price), 3) avg_sale_price
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
ORDER BY 4 DESC;

-- Berapa revenue yang dihasilkan?
SELECT
  ROUND(SUM(sale_price) / 1000000, 2) total_revenue_in_million
FROM bigquery-public-data.thelook_ecommerce.order_items;

-- Berapa total product dan rata-rata harga product per kategori
SELECT 
  category,
  COUNT(*) total_item,
  AVG(retail_price) rata2_harga
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY 1
ORDER BY 3 DESC;

--Berapa jumlah transaksi, jumlah sale price, rata-rata nilai per transaksi (AOV) untuk masing-masing user, Tampilkan hanya 10 user
SELECT 
user_id,
Count (distinct order_id) as Jumlah_Order,
ROUND(SUM(sale_price),2) total_sales,
ROUND (Avg(sale_price),2) Rata_Harga_Jual,
FROM bigquery-public-data.thelook_ecommerce.order_items
Group by 1
Order by 3 DESC
LIMIT 10;

-- Correct Answer
SELECT
  user_id,
  COUNT(DISTINCT order_id) AS total_transaksi,
  ROUND(SUM(sale_price), 2) AS total_sale_price,
  ROUND(SUM(sale_price) / COUNT(DISTINCT order_id), 2) AS aov # Perhitungan AVerage Order Value (AOV)
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY user_id
ORDER BY total_sale_price DESC
LIMIT 10;

SELECT
  user_id,
  sum(sale_price) AS salePrice,
  COUNT(order_id) AS jumlahOrder,
  round(avg(sale_price), 2) AS avg_per_transaksi
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY user_id
ORDER BY salePrice DESC
LIMIT 10;

SELECT
user_id,
COUNT (DISTINCT order_id) jumlah_order,
ROUND(SUM(sale_price), 2) total_sales,
ROUND (Avg(sale_price), 2) rata2_trx
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10;

SELECT
  user_id,
  SUM(sale_price) total_sales,
  SUM(sale_price) / COUNT(*) jumlah_item
FROM bigquery-public-data.thelook_ecommerce.order_items
GROUP BY 1
ORDER BY 2 DESC;