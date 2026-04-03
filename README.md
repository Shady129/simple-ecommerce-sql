# 🛒 Simple Ecommerce Database (SQL Server)

---

## 🚀 Project Overview

This is a simple **SQL Server Database Project** that demonstrates:

* ✔ Database Design (Users, Products, Orders)
* ✔ Stored Procedures (CRUD + Queries)
* ✔ JOIN & GROUP BY
* ✔ IF + RETURN Validation
* ✔ SCOPE_IDENTITY() Usage
* ✔ Clean and Organized SQL Script

This project was built as a **practical training** to understand how databases work in real-world applications.

---

## 🏗 Database Structure

### 🔹 Core Tables

* Users
* Products
* Orders
* OrderItems

---

### 🔹 Relationships

* Orders → linked to Users
* OrderItems → linked to Orders & Products

---

## 📌 Stored Procedures

### 🟢 Products

| Procedure          | Description              |
| ------------------ | ------------------------ |
| GetAllProducts     | Get all products         |
| GetProductsByPrice | Filter products by price |
| UpdateProduct      | Update product           |
| DeleteProduct      | Delete product           |

---

### 🔵 Orders

| Procedure            | Description               |
| -------------------- | ------------------------- |
| GetOrderDetails      | Get order full details    |
| GetOrderTotal        | Calculate total price     |
| CheckOrderItemStatus | Check if order has items  |
| CreateOrder          | Create order and add item |
| GetOrdersByUser      | Get orders by user        |

---

## 🧠 Concepts Learned

* ✔ Stored Procedures Design
* ✔ Database Relationships (FK)
* ✔ JOIN Operations
* ✔ GROUP BY & Aggregation
* ✔ Validation using IF + RETURN
* ✔ Using SCOPE_IDENTITY()
* ✔ Writing Clean SQL Code

---

## ⚠ Note

This project uses **manual SQL scripting**
for learning and demonstration purposes.

---

## 🛠 Technologies Used

* SQL Server
* T-SQL
* SSMS (SQL Server Management Studio)

---

## 📈 Future Improvements (Optional)

* Add Stock Validation
* Handle Multiple Products per Order
* Add Transaction Handling
* Improve Error Handling
* Connect with C# Application (ADO.NET / API)

---

## 👨‍💻 Author

Shady Mahmoud
Backend Developer (.NET)

---

⭐ If you like this project, feel free to star the repository.
