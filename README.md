# Sales Dashboard – Power BI + PostgreSQL

## 1. Database Connection

The project uses **PostgreSQL** as the main data source with a star-schema model.

**Database:** `RIWI_VENTAS`  
**User:** postgres  
**Port:** 5432  

### Connection Steps in Power BI
1. Go to **Home → Get Data → PostgreSQL**  
2. Enter:
   - **Server:** localhost  
   - **Database:** RIWI_VENTAS  
3. Choose the authentication method.  
4. Load the following tables:

- `ventas` (fact table)
- `dim_ciudad`
- `dim_producto`
- `dim_tipo_cliente`
- `dim_tipo_venta`
- `dim_fecha`

---

## 2. Star Schema Model

### Fact Table: `ventas`
Contains numerical metrics:
- cantidad  
- precio_unitario  
- descuento  
- costo_envio  
- total  
- id_fecha  
- id_ciudad  
- id_producto  
- id_tipo_cliente  
- id_tipo_venta  

### Dimension Tables
Each dimension has a primary key (`id_*`) and descriptive attributes.

### Relationships in Power BI
- All relationships: **1-to-many (1:*)**  
- Direction: **Single**  
- From dimension → fact table  

Example:
```
dim_producto[id_producto] 1 → * ventas[id_producto]
```

---

## 3. Visualizations

### 3.1 KPI Cards
**DAX Measures:**
```DAX
Total Ventas = SUM(ventas[total])

Ticket Promedio = DIVIDE([Total Ventas], [Total Cantidad], 0)
```

**Steps:**
1. Insert KPI card  
2. Drag each measure  
3. Format units → *None* or *Currency*

---

###  3.2 Line Chart – Current Year vs Previous Year

**DAX Measures:**
```DAX
Ventas Año Actual =
CALCULATE([Total Ventas], YEAR(dim_fecha[fecha]) = YEAR(TODAY()))

Ventas Año Anterior =
CALCULATE([Total Ventas], YEAR(dim_fecha[fecha]) = YEAR(TODAY()) - 1)
```

**Steps:**
- Axis: `dim_fecha[fecha]` or `dim_fecha[mes]`
- Values:  
  - Ventas Año Actual  
  - Ventas Año Anterior  

---

###  3.3 Top 5 Products (Clustered Column Chart)

Steps:
1. Insert clustered column chart  
2. Axis → `dim_producto[producto]`  
3. Values → `Total Ventas`  
4. Filters → **Top N = 5** → By: Total Ventas → Apply  

---

###  3.4 Donut Chart – Top Categories
- Legend → `dim_producto[tipo_producto]`
- Values → `Total Ventas`
- Remove "SinDato" using visual-level filters

---

###  3.5 Filled Map – Sales by Region

**Fields:**
- Location → `dim_ciudad[pais]`
- Color saturation → `Total Ventas`

**Important:**  
- Select `"Country"` as the Data Category for country column  
- Add a `country` column if needed for accurate geocoding  

---

###  3.6 Slicers
Add the following slicers:

####  Slicer by Region
`dim_ciudad[ciudad]`

####  Slicer by Category
`dim_producto[tipo_producto]`

####  Slicer by Date (Between)
`dim_fecha[fecha]` → Change slicer type to **Between**

---

## 4. Dynamic Filters

Use the **Filters Pane** for:
- Report-level filters  
- Page-level filters  
- Visual-level filters  

---

## 5. Dashboard Screenshots
Add images such as:  
- `average.png`  
- `bycustomer.png`  
- `currentvs.png`  
- `date.png`  
- `grafico.png`  
- `salesbycountry.png`  
- `totalsales.png`  
---

## 6. Insights 


- The top-performing cities are Cusco, Sevilla, and Arequipa, showing the strongest sales volumes.  
- These cities include major touristic and commercial locations, which may explain higher product turnover. 
- Lower-performing cities within the Top 10 ,such as Trujillo and Antofagasta, show slower growth despite being in the high-sales group.
- Cheese, Yogurt, and Coffee are the top-selling products, driving most of the companys revenue.
- Chocolate is the lowest-selling item among the top products, indicating an opportunity for improvement or repositioning.
- The Dairy category represents the highest revenue share, contributing nearly 40% of total sales.
- Beverages and Groceries maintain similar sales levels, suggesting strong cross-selling potential.
- Sales are evenly distributed across customer types (Retail, Wholesale, Government, Corporate), which reduces dependency risks.
- Retail customers hold a slight advantage, indicating a healthy B2C performance.
- Online is the strongest sales channel, slightly above Call Center, confirming a growing digital purchasing trend.
- Physical Store and Distributor channels lag behind, indicating opportunity for operational or marketing improvements.
- Sales across countries are highly balanced.
- Colombia leads, but by a small margin, showing a stable regional market without extreme concentration in one territory.
- The global average ticket of 3,113 indicates a medium–high customer spending behavior, supporting strategies like bundles and premium product offerings.


---

## 7. Recommendations
- Strengthen inventory and promotional activities in Cusco, Sevilla, and Arequipa to maintain momentum.
- Implement activation campaigns and seasonal promotions in lower-growth cities to stimulate demand. 
- Continue boosting Dairy products, ensuring high availability due to their large revenue contribution.
- Use bundles or cross-selling (e.g., coffee + pastries, cheese + bread) to increase the average ticket.
- Reposition Chocolate with seasonal campaigns, new formats, or targeted promotions.
- Design combined promotions between Beverages and Groceries, as both categories show similar performance and complement each other.
- Enhance retail loyalty initiatives (discounts, membership, reward points).
- For Corporate and Government clients, develop recurring purchase agreements with preferential pricing
- Invest in digital marketing, UX improvements, and delivery optimization to capitalize on the strong Online channel.
- For Physical Store and Distributors, consider: Assortment optimization, Local campaigns , Training sales reps
- Since countries show balanced performance, apply regional marketing strategies and negotiate better terms with local distributors.
- Sales across countries are highly balanced.
- Prioritize Colombia with premium product campaigns.
- Apply upselling strategies such as:Larger-size discounts, Premium bundles, “Buy 2, get 1” promotions

---

## 8. Author
**Created by:** Nadine Castillo  
**Tools:** Python, Pandas, PostgreSQL, DBeaver, Power BI  
**Year:** 2025
