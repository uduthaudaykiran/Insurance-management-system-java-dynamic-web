# Insurance Management System – Java Web Project

An end-to-end Java-based project developed using **Eclipse JEE Neon**, integrating **Console**, **JDBC**, **Servlets**, and **JSP** with **Apache Derby** and **Apache Tomcat** to manage customers, bills, policies, and complaints.

This is an Insurance Management System developed using Java EE technologies including JSP, Servlets, JDBC, and Apache Derby database. The system provides both console-based and web-based interfaces for managing insurance policies, customers, bills, and complaints.

---

## 📂 Project Structure

```
InsuranceManagementSystem/
│
├── src/
│   ├── model/ - Entity classes
│   ├── dao/ - Data Access Objects
│   ├── service/ - Business logic
│   ├── exceptions/ - Custom exceptions
│   ├── thread/ - Thread implementations
│   ├── utils/ - Utility classes
│   ├── web/ - Servlets                  
│   └── InsuranceManagementSystem.java   <-- Console entry point
│
├── WebContent/
│   ├── WEB-INF/
│   │   ├── web.xml - Deployment descriptor
│   │   └── lib/ - Library JARs          <-- derbyclient.jar
│   └── *.jsp  - All view pages          <-- All JSPs
│
├── build/
├── screenshots/              <-- Optional folder for UI screenshots
└── README.md
```

## 🛠️ Tech Stack

| Component   | Technology            |
| ----------- | --------------------- |
| IDE         | Eclipse JEE Neon 3 (Win32-x86_64) |
| Language    | Java (JDK 8+)         |
| Web Layer   | JSP, Servlets         |
| Backend DB  | Apache Derby 10.2.2.0 |
| Server      | Apache Tomcat 9.0     |
| JDBC Driver | derbyclient.jar       |
| Markup      | JSP + external CSS    |
| XML         | 3.1                   |
| Other       | JDBC                  |

---

## ⚙️ Setup Instructions

### Step 1: Add Apache Tomcat in Eclipse

1. Open Eclipse → `Window` → `Preferences` → `Server` → `Runtime Environments`
2. Click `Add…` → Select **Apache Tomcat v9.0**
3. Browse Tomcat installation directory and finish.

### Step 2: Add Apache Derby in Eclipse

1. Add `derbyclient.jar` to Eclipse classpath:

   * Right-click project → `Build Path` → `Add External Archives…` → Add `derbyclient.jar`
2. Go to `Window` → `Show View` → `Data Source Explorer`
3. Add Derby embedded connection with database `jdbc:derby://localhost:1527/db;create=true`

---

## ▶️ How to Run Console Application

1. Right-click `InsuranceManagementSystem.java` → `Run As → Java Application`
2. Interact with menu: policy listing, customer registration, complaint handling, bill viewing, etc.

---

## 🌐 How to Run Web Application (JSP/Servlet)

1. Right-click project → `Run on Server`
2. Login/Register as a customer via `login.jsp` or `register.jsp`
3. Navigate using top menu: Home, Pay Bill, Register Complaint, Complaint Status, Bill History

---

## Database Setup
1. Create a new Derby database:
   - In Eclipse, open the Data Source Explorer view
   - Right-click on Databases → New → Derby Connection
   - Configure with database name "InsuranceDB" and schema "user"
   - Test connection and finish

2. 🗃️ SQL Scrapbook Usage

To view/modify Derby DB:

1. `Window → Show View → Data Source Explorer`
2. Connect to Derby → Right-click schema `USER` → `New SQL Scrapbook`
3. Use queries like:

   ```sql
   SELECT * FROM "USER."CUSTOMER";
   SELECT * FROM "USER."BILL";
   ```

---

## 🔍 Why Console + Web

* **Console:** Quick testing, threading (bill generation), exception demonstration, inheritance.
* **Web (JSP/Servlet):** Real-world customer-facing UI for registration, complaints, payments.

---

## 🚀 Features Implemented

### ✅ Core Console

* Menu System
* Customer Registration, Search, Email Domain View
* Policy Listing

### ✅ JDBC & DB Integration

* Persistent Registration
* Bill Table with Relations
* Complaint Handling

### ✅Advanced Java

* Threaded Bill Generation
* Inheritance-based Complaints
* Custom Exceptions for validations

### ✅ JSP/Servlets

* Customer Self-Registration
* Login/Logout
* Pay Bill (with receipt download)
* Complaint Registration/Status
* View Bill History
* View All Complaints (Admin)

---

## Key Features

### Console Features:
1. Menu-based console interface
2. Policy listing
3. Customer registration with validation
4. Search customers by email or ID
5. View customers by email domain
6. Bill management
7. Complaint registration

### Web Features:
1. Customer registration with form validation
2. Bill viewing and payment
3. Complaint registration and status tracking
4. Admin dashboard for managing complaints
5. Bill history viewing

## Technical Implementations

1. **Custom Exceptions**: `EmailAlreadyExistException`, `CustomerNotFoundException`
2. **Polymorphism**: Bill search by either email or bill number
3. **Inheritance**: `Complaint` class inherits from `Consumer`
4. **Multithreading**: Concurrent bill generation using `BillGenerationThread`
5. **JDBC**: Database connectivity with connection pooling
6. **Servlet/JSP**: MVC architecture for web interface

---

## 🔄 Future Modifications

**System Requirements:**
1. **User Roles & UI:** Role-based interfaces (Admin, CSR, Customer) with mobile-responsive design (Bootstrap/React)
2. **Security:**  
   - Spring Security for authentication  
   - Email OTP verification
3. **Backend:**  
   - Spring Boot REST API  
   - Dependency injection (Spring Framework)  
   - Hibernate ORM
4. **Features:**  
   - PDF generation for bills/receipts  
   - Payment gateway integration  
   - Enhanced reporting
5. **Quality Assurance:**  
   - Unit testing (JUnit/TestNG)

Key improvements:
- Merged REST API conversion with Spring Boot implementation
- Grouped all security-related items
- Consolidated frontend technologies under UI
- Removed redundant "implementation" verbs
- Organized by logical categories (UI, Security, Backend, etc.)

---

## Screenshots
(Screenshots in a `screenshots` folder to demonstrate the application flow)

---

## Usage Notes
- The console application is designed for administrative tasks
- The web application provides customer-facing features
- Derby database stores all persistent data
- Tomcat serves as the servlet container for the web application

---

## Troubleshooting
- Ensure all required JARs are in WEB-INF/lib
- Check database connection parameters in `DatabaseUtility.java`
- Verify Tomcat server configuration
- Ensure proper JDK version is configured in Eclipse

---

## 📜 License

[MIT License](LICENSE)
