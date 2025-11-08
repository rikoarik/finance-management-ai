<!-- a3ed802e-6ed0-461b-b6d1-9e309ffbfe6b 38a822d5-d251-4e04-ac3b-5cc99deaa9a3 -->
# Rencana Lengkap: Backend API - User & Admin Endpoints

## Overview

Pembangunan backend REST API lengkap dengan 2 bagian utama:

1. **API untuk User/Mobile App** - Endpoints untuk aplikasi Flutter
2. **API untuk Admin** - Endpoints khusus admin dengan Role-Based Access Control (RBAC)

**Catatan**: Admin Panel/CMS frontend akan dibuat pada fase terpisah nanti. Fokus sekarang pada backend API saja.

**Prioritas Development:**

1. Database Schema & Setup
2. Authentication System (User + Admin)
3. User API Endpoints (untuk mobile app)
4. Admin API Endpoints (dengan RBAC)
5. Testing & Deployment

---

## FASE 0: Persiapan & Planning (Week 1, Days 1-2)

### 0.1 Decision Matrix - Pilih Stack Teknologi

**Backend Framework Options:**

- [ ] **Node.js + Express** (Recommended untuk JavaScript developer)
- [ ] **Python + FastAPI** (Recommended untuk Python developer)
- [ ] **Laravel (PHP)** (Recommended untuk PHP developer)

**Database Options:**

- [ ] **PostgreSQL** (Recommended)
- [ ] **MySQL/MariaDB**

**Decision:**

```
Pilih salah satu kombinasi:
[ ] Node.js + Express + PostgreSQL
[ ] Node.js + Express + MySQL
[ ] Python + FastAPI + PostgreSQL
[ ] Laravel + MySQL
```

### 0.2 Environment Setup Checklist

**Backend Development:**

- [ ] Install Node.js (v18+) atau Python (v3.10+)
- [ ] Install PostgreSQL/MySQL
- [ ] Install database client (pgAdmin, MySQL Workbench)
- [ ] Setup Git repository untuk backend
- [ ] Setup IDE/Editor (VSCode recommended)

**Tools:**

- [ ] Postman/Insomnia untuk API testing
- [ ] Database migration tool
- [ ] API documentation tool (Swagger)

---

## FASE 1: Database Setup (Week 1, Days 3-5)

### 1.1 Database Schema - User Tables

**Tabel Users:**

```sql
CREATE TABLE users (
    id VARCHAR(36) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    photo_url TEXT,
    email_verified_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_created_at (created_at)
);
```

**Tabel Transactions:**

```sql
CREATE TABLE transactions (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    type ENUM('income', 'expense') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_date (user_id, date DESC),
    INDEX idx_user_type (user_id, type),
    INDEX idx_category (category)
);
```

**Tabel Budgets:**

```sql
CREATE TABLE budgets (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    monthly_income DECIMAL(15, 2) NOT NULL,
    month_start DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_month (user_id, month_start),
    INDEX idx_user_month (user_id, month_start DESC)
);
```

**Tabel Budget Categories:**

```sql
CREATE TABLE budget_categories (
    id VARCHAR(36) PRIMARY KEY,
    budget_id VARCHAR(36) NOT NULL,
    name VARCHAR(100) NOT NULL,
    allocation_percentage DECIMAL(5, 4) NOT NULL,
    allocated_amount DECIMAL(15, 2) NOT NULL,
    spent_amount DECIMAL(15, 2) DEFAULT 0.00,
    available_amount DECIMAL(15, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (budget_id) REFERENCES budgets(id) ON DELETE CASCADE,
    INDEX idx_budget (budget_id)
);
```

**Tabel Recurring Transactions:**

```sql
CREATE TABLE recurring_transactions (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    type ENUM('income', 'expense') NOT NULL,
    category VARCHAR(100) NOT NULL,
    note TEXT,
    frequency ENUM('daily', 'weekly', 'monthly', 'yearly') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    last_created DATE NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_active (user_id, is_active)
);
```

**Tabel Chat Messages:**

```sql
CREATE TABLE chat_messages (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    message TEXT NOT NULL,
    is_user BOOLEAN NOT NULL,
    transaction_data JSON NULL,
    file_url TEXT NULL,
    file_name VARCHAR(255) NULL,
    file_type VARCHAR(50) NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_timestamp (user_id, timestamp DESC)
);
```

**Tabel User Settings:**

```sql
CREATE TABLE user_settings (
    user_id VARCHAR(36) PRIMARY KEY,
    theme_mode VARCHAR(20) DEFAULT 'system',
    language VARCHAR(10) DEFAULT 'id',
    api_key_encrypted TEXT NULL,
    ai_provider VARCHAR(50) DEFAULT 'gemini',
    daily_notification BOOLEAN DEFAULT FALSE,
    budget_alert BOOLEAN DEFAULT TRUE,
    weekly_summary BOOLEAN DEFAULT FALSE,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

**Tabel User Subscriptions:**

```sql
CREATE TABLE user_subscriptions (
    user_id VARCHAR(36) PRIMARY KEY,
    subscription_type ENUM('trial', 'pro_monthly', 'pro_unlimited') DEFAULT 'trial',
    is_premium BOOLEAN DEFAULT FALSE,
    is_unlimited BOOLEAN DEFAULT FALSE,
    skip_trial BOOLEAN DEFAULT FALSE,
    trial_start_date TIMESTAMP NULL,
    trial_end_date TIMESTAMP NULL,
    subscription_start_date TIMESTAMP NULL,
    subscription_end_date TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_subscription_type (subscription_type),
    INDEX idx_is_premium (is_premium),
    INDEX idx_trial_end (trial_end_date),
    INDEX idx_subscription_end (subscription_end_date)
);
```

### 1.2 Database Schema - Admin Tables

**Tabel Admins:**

```sql
CREATE TABLE admins (
    id VARCHAR(36) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role ENUM('super_admin', 'admin', 'moderator') NOT NULL DEFAULT 'admin',
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_active (is_active)
);
```

**Tabel Admin Sessions (untuk token refresh tracking):**

```sql
CREATE TABLE admin_sessions (
    id VARCHAR(36) PRIMARY KEY,
    admin_id VARCHAR(36) NOT NULL,
    refresh_token VARCHAR(255) UNIQUE NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE,
    INDEX idx_admin (admin_id),
    INDEX idx_token (refresh_token),
    INDEX idx_expires (expires_at)
);
```

**Tabel Audit Logs (untuk tracking admin actions):**

```sql
CREATE TABLE audit_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    admin_id VARCHAR(36) NULL,
    user_id VARCHAR(36) NULL,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id VARCHAR(36) NULL,
    old_values JSON NULL,
    new_values JSON NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_admin (admin_id),
    INDEX idx_user (user_id),
    INDEX idx_action (action),
    INDEX idx_entity (entity_type, entity_id),
    INDEX idx_created (created_at DESC)
);
```

**Checklist:**

- [ ] All user tables created
- [ ] Admin tables created
- [ ] All indexes created
- [ ] Foreign keys working
- [ ] Test insert/update/delete operations

---

## FASE 2A: User API Endpoints (Week 2-3)

### 2A.1 Authentication Endpoints

**POST `/api/auth/register`**

- Register user baru
- Request: `{ email, password, name }`
- Response: `{ user, access_token, refresh_token }`

**POST `/api/auth/login`**

- Login user
- Request: `{ email, password }`
- Response: `{ user, access_token, refresh_token }`

**POST `/api/auth/refresh-token`**

- Refresh access token
- Request: `{ refresh_token }`
- Response: `{ access_token, refresh_token }`

**POST `/api/auth/logout`**

- Logout user (invalidate refresh token)
- Headers: `Authorization: Bearer <token>`

**POST `/api/auth/reset-password`**

- Request password reset
- Request: `{ email }`

**POST `/api/auth/verify-email`**

- Verify email address
- Request: `{ token }`

### 2A.2 Transaction Endpoints

**GET `/api/transactions`**

- List transactions dengan pagination & filters
- Query params: `page, limit, type, startDate, endDate, category`
- Headers: `Authorization: Bearer <token>`

**GET `/api/transactions/:id`**

- Get single transaction
- Headers: `Authorization: Bearer <token>`

**POST `/api/transactions`**

- Create transaction
- Request: `{ type, amount, category, date, note }`
- Headers: `Authorization: Bearer <token>`

**PUT `/api/transactions/:id`**

- Update transaction
- Request: `{ type?, amount?, category?, date?, note? }`
- Headers: `Authorization: Bearer <token>`

**DELETE `/api/transactions/:id`**

- Delete transaction
- Headers: `Authorization: Bearer <token>`

**GET `/api/transactions/summary`**

- Get summary (total income/expense/balance)
- Query params: `startDate?, endDate?`
- Headers: `Authorization: Bearer <token>`

**GET `/api/transactions/date-range`**

- Get transactions by date range
- Query params: `startDate, endDate, type?, category?`
- Headers: `Authorization: Bearer <token>`

### 2A.3 Budget Endpoints

**GET `/api/budgets`**

- List budgets dengan pagination
- Query params: `page, limit`
- Headers: `Authorization: Bearer <token>`

**GET `/api/budgets/current`**

- Get current month budget
- Headers: `Authorization: Bearer <token>`

**GET `/api/budgets/:id`**

- Get single budget dengan categories
- Headers: `Authorization: Bearer <token>`

**POST `/api/budgets`**

- Create budget
- Request: `{ monthlyIncome, categories: [{ name, allocationPercentage, allocatedAmount }] }`
- Headers: `Authorization: Bearer <token>`

**PUT `/api/budgets/:id`**

- Update budget
- Request: `{ monthlyIncome?, categories? }`
- Headers: `Authorization: Bearer <token>`

**DELETE `/api/budgets/:id`**

- Delete budget
- Headers: `Authorization: Bearer <token>`

**PUT `/api/budgets/:id/recalculate`**

- Recalculate spent amounts dari transactions
- Headers: `Authorization: Bearer <token>`

### 2A.4 Recurring Transaction Endpoints

**GET `/api/recurring-transactions`**

- List recurring transactions
- Query params: `isActive?`
- Headers: `Authorization: Bearer <token>`

**GET `/api/recurring-transactions/:id`**

- Get single recurring transaction
- Headers: `Authorization: Bearer <token>`

**POST `/api/recurring-transactions`**

- Create recurring transaction
- Request: `{ amount, type, category, note, frequency, startDate, endDate? }`
- Headers: `Authorization: Bearer <token>`

**PUT `/api/recurring-transactions/:id`**

- Update recurring transaction
- Headers: `Authorization: Bearer <token>`

**DELETE `/api/recurring-transactions/:id`**

- Delete recurring transaction
- Headers: `Authorization: Bearer <token>`

**POST `/api/recurring-transactions/:id/execute`**

- Manually trigger recurring transaction
- Headers: `Authorization: Bearer <token>`

### 2A.5 Chat Message Endpoints

**GET `/api/chat/messages`**

- Get chat history
- Query params: `page?, limit?`
- Headers: `Authorization: Bearer <token>`

**POST `/api/chat/messages`**

- Save chat message
- Request: `{ message, isUser, transactionData?, fileUrl?, fileName?, fileType? }`
- Headers: `Authorization: Bearer <token>`

**DELETE `/api/chat/messages`**

- Clear chat history (delete all user messages)
- Headers: `Authorization: Bearer <token>`

### 2A.6 Analytics Endpoints

**GET `/api/analytics/summary`**

- Get financial summary
- Query params: `startDate?, endDate?`
- Headers: `Authorization: Bearer <token>`

**GET `/api/analytics/by-category`**

- Spending by category
- Query params: `startDate?, endDate?, type?`
- Headers: `Authorization: Bearer <token>`

**GET `/api/analytics/trends`**

- Monthly trends
- Query params: `months?` (default: 6)
- Headers: `Authorization: Bearer <token>`

**GET `/api/analytics/spending-patterns`**

- Analyze spending patterns
- Query params: `startDate?, endDate?`
- Headers: `Authorization: Bearer <token>`

### 2A.7 User Profile Endpoints

**GET `/api/users/profile`**

- Get user profile
- Headers: `Authorization: Bearer <token>`

**PUT `/api/users/profile`**

- Update profile
- Request: `{ name?, photoUrl? }`
- Headers: `Authorization: Bearer <token>`

**PUT `/api/users/avatar`**

- Update avatar (upload file)
- Request: `multipart/form-data` dengan file
- Headers: `Authorization: Bearer <token>`

**GET `/api/users/settings`**

- Get user settings
- Headers: `Authorization: Bearer <token>`

**PUT `/api/users/settings`**

- Update settings
- Request: `{ themeMode?, language?, apiKeyEncrypted?, aiProvider?, dailyNotification?, budgetAlert?, weeklySummary? }`
- Headers: `Authorization: Bearer <token>`

**Checklist:**

- [ ] All user API endpoints implemented
- [ ] Authentication working
- [ ] CRUD operations tested
- [ ] Pagination working
- [ ] Filters working
- [ ] Error handling implemented

---

## FASE 2B: Admin API Endpoints (Week 3-4)

### 2B.1 Admin Authentication Endpoints

**POST `/api/admin/auth/login`**

- Admin login
- Request: `{ email, password }`
- Response: `{ admin, access_token, refresh_token }`

**POST `/api/admin/auth/refresh-token`**

- Refresh admin access token
- Request: `{ refresh_token }`
- Response: `{ access_token, refresh_token }`

**POST `/api/admin/auth/logout`**

- Admin logout (invalidate session)
- Headers: `Authorization: Bearer <admin_token>`

**GET `/api/admin/auth/me`**

- Get current admin info
- Headers: `Authorization: Bearer <admin_token>`

**PUT `/api/admin/auth/change-password`**

- Change admin password
- Request: `{ currentPassword, newPassword }`
- Headers: `Authorization: Bearer <admin_token>`

### 2B.2 Admin Middleware & RBAC

**Admin Authentication Middleware:**

- Verify admin JWT token
- Check if admin is active
- Attach admin info to request

**Role-Based Access Control:**

- **super_admin**: Full access (all endpoints)
- **admin**: Can manage users, view all data, moderate content
- **moderator**: Can view data, limited edit access

**Permission System:**

```javascript
const permissions = {
  'users.view': ['super_admin', 'admin', 'moderator'],
  'users.create': ['super_admin', 'admin'],
  'users.update': ['super_admin', 'admin'],
  'users.delete': ['super_admin'],
  'transactions.view': ['super_admin', 'admin', 'moderator'],
  'transactions.delete': ['super_admin', 'admin'],
  'budgets.view': ['super_admin', 'admin', 'moderator'],
  'admin.manage': ['super_admin'],
  'system.settings': ['super_admin']
};
```

### 2B.3 Admin User Management Endpoints

**GET `/api/admin/users`**

- List all users dengan pagination & filters
- Query params: `page, limit, search?, sortBy?, sortOrder?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/users/:id`**

- Get user details dengan statistics
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**POST `/api/admin/users`**

- Create new user (manual registration)
- Request: `{ email, password, name }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.create`

**PUT `/api/admin/users/:id`**

- Update user
- Request: `{ name?, email?, photoUrl? }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**DELETE `/api/admin/users/:id`**

- Delete user (soft delete atau hard delete)
- Query params: `hardDelete?` (default: false)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.delete`

**PUT `/api/admin/users/:id/suspend`**

- Suspend/unsuspend user
- Request: `{ suspended: true/false, reason? }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**GET `/api/admin/users/:id/transactions`**

- Get all transactions of a user
- Query params: `page, limit, type?, startDate?, endDate?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.view`

**GET `/api/admin/users/:id/budgets`**

- Get all budgets of a user
- Query params: `page, limit`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `budgets.view`

**GET `/api/admin/users/:id/statistics`**

- Get user statistics
- Response: `{ totalTransactions, totalIncome, totalExpense, activeBudgets, joinedDate, lastActivity }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

### 2B.4 Admin Transaction Management Endpoints

**GET `/api/admin/transactions`**

- List all transactions (across all users)
- Query params: `page, limit, userId?, type?, startDate?, endDate?, category?, search?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.view`

**GET `/api/admin/transactions/:id`**

- Get transaction details
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.view`

**PUT `/api/admin/transactions/:id`**

- Update transaction (admin override)
- Request: `{ type?, amount?, category?, date?, note? }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.update`

**DELETE `/api/admin/transactions/:id`**

- Delete transaction (admin override)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.delete`

**GET `/api/admin/transactions/statistics`**

- Get global transaction statistics
- Query params: `startDate?, endDate?`
- Response: `{ totalTransactions, totalIncome, totalExpense, avgTransactionAmount, topCategories }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.view`

**GET `/api/admin/transactions/export`**

- Export transactions to CSV/Excel
- Query params: `format?` (csv/xlsx), `userId?, startDate?, endDate?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.view`

### 2B.5 Admin Budget Management Endpoints

**GET `/api/admin/budgets`**

- List all budgets (across all users)
- Query params: `page, limit, userId?, monthStart?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `budgets.view`

**GET `/api/admin/budgets/:id`**

- Get budget details dengan categories
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `budgets.view`

**GET `/api/admin/budgets/statistics`**

- Get global budget statistics
- Response: `{ totalBudgets, avgMonthlyIncome, totalUsersWithBudget, budgetDistribution }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `budgets.view`

### 2B.6 Admin Subscription Management Endpoints

**GET `/api/admin/subscriptions`**

- List all user subscriptions dengan pagination & filters
- Query params: `page, limit, subscriptionType?, isPremium?, isActive?, search?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/subscriptions/:userId`**

- Get user subscription details
- Response: `{ subscriptionType, isPremium, isUnlimited, trialStartDate, trialEndDate, remainingTrialDays, skipTrial }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**PUT `/api/admin/subscriptions/:userId`**

- Update user subscription
- Request: `{ subscriptionType?: 'trial'|'pro_monthly'|'pro_unlimited', isPremium?: boolean, isUnlimited?: boolean, trialStartDate?: string, trialEndDate?: string, skipTrial?: boolean }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**POST `/api/admin/subscriptions/:userId/trial`**

- Start trial for user (14 days default)
- Request: `{ days?: number }` (default: 14)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**PUT `/api/admin/subscriptions/:userId/upgrade`**

- Upgrade user to premium (pro_monthly or pro_unlimited)
- Request: `{ subscriptionType: 'pro_monthly'|'pro_unlimited', skipTrial?: boolean }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**PUT `/api/admin/subscriptions/:userId/downgrade`**

- Downgrade user to free tier
- Request: `{ reason?: string }` (optional reason for downgrade)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**POST `/api/admin/subscriptions/:userId/extend-trial`**

- Extend trial period
- Request: `{ additionalDays: number }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.update`

**GET `/api/admin/subscriptions/statistics`**

- Get subscription statistics
- Response: `{ totalUsers, trialUsers, premiumUsers, unlimitedUsers, trialExpiringSoon, trialExpired, revenue }`
- Query params: `startDate?, endDate?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/subscriptions/expiring-trials`**

- Get users with trials expiring soon
- Query params: `days?: number` (default: 7)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/subscriptions/expired-trials`**

- Get users with expired trials
- Query params: `page, limit`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/subscriptions/revenue`**

- Get revenue statistics (if payment integration exists)
- Query params: `startDate?, endDate?, groupBy?: 'day'|'week'|'month'`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

### 2B.7 Admin Analytics & Reports Endpoints

**GET `/api/admin/analytics/overview`**

- Get overview statistics
- Response: `{ totalUsers, activeUsers, totalTransactions, totalIncome, totalExpense, avgUserIncome, growthRate }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/analytics/users-growth`**

- Get user growth over time
- Query params: `startDate?, endDate?, interval?` (day/week/month)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/analytics/revenue`**

- Get revenue statistics (if applicable)
- Query params: `startDate?, endDate?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/analytics/categories`**

- Get category usage statistics
- Query params: `startDate?, endDate?`
- Response: `{ topCategories, categoryDistribution }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `transactions.view`

**GET `/api/admin/reports/daily`**

- Get daily report
- Query params: `date?` (default: today)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/reports/weekly`**

- Get weekly report
- Query params: `week?` (YYYY-WW format)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/reports/monthly`**

- Get monthly report
- Query params: `month?` (YYYY-MM format)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

### 2B.7 Admin Management Endpoints

**GET `/api/admin/admins`**

- List all admins
- Query params: `page, limit, role?, isActive?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `admin.manage` (super_admin only)

**GET `/api/admin/admins/:id`**

- Get admin details
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `admin.manage`

**POST `/api/admin/admins`**

- Create new admin
- Request: `{ email, password, name, role }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `admin.manage`

**PUT `/api/admin/admins/:id`**

- Update admin
- Request: `{ name?, role?, isActive? }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `admin.manage`

**DELETE `/api/admin/admins/:id`**

- Delete admin (cannot delete self)
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `admin.manage`

**PUT `/api/admin/admins/:id/activate`**

- Activate/deactivate admin
- Request: `{ isActive: true/false }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `admin.manage`

### 2B.8 Admin System Settings Endpoints

**GET `/api/admin/settings`**

- Get system settings
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `system.settings` (super_admin only)

**PUT `/api/admin/settings`**

- Update system settings
- Request: `{ maintenanceMode?, maxFileSize?, allowedFileTypes?, emailConfig?, smsConfig? }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `system.settings`

### 2B.9 Admin Audit Log Endpoints

**GET `/api/admin/audit-logs`**

- Get audit logs
- Query params: `page, limit, adminId?, userId?, action?, entityType?, startDate?, endDate?`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**GET `/api/admin/audit-logs/:id`**

- Get audit log details
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

### 2B.10 Admin Dashboard Statistics Endpoint

**GET `/api/admin/dashboard/stats`**

- Get dashboard statistics (all-in-one)
- Response: `{ users, transactions, budgets, revenue, growth, recentActivity }`
- Headers: `Authorization: Bearer <admin_token>`
- Permissions: `users.view`

**Checklist:**

- [ ] Admin authentication implemented
- [ ] RBAC middleware working
- [ ] All admin endpoints implemented
- [ ] Permission checking working
- [ ] Audit logging implemented
- [ ] Admin endpoints tested

---

## FASE 3: Middleware & Utilities (Week 4)

### 3.1 Middleware Implementation

**Authentication Middleware:**

- [ ] User authentication middleware
- [ ] Admin authentication middleware
- [ ] Token refresh middleware

**Authorization Middleware:**

- [ ] RBAC middleware untuk admin
- [ ] Permission checking

**Validation Middleware:**

- [ ] Request validation (Joi/express-validator)
- [ ] Input sanitization

**Error Handling:**

- [ ] Global error handler
- [ ] Custom error classes
- [ ] Error logging

**Security Middleware:**

- [ ] Rate limiting
- [ ] CORS configuration
- [ ] Helmet.js security headers
- [ ] SQL injection prevention

### 3.2 Utility Functions

**Response Helper:**

- [ ] Standard success response format
- [ ] Standard error response format

**Logging:**

- [ ] Request logging
- [ ] Error logging
- [ ] Audit logging untuk admin actions

**File Upload:**

- [ ] File upload handler
- [ ] Image processing (resize, compress)
- [ ] File storage (local/S3)

**Email Service:**

- [ ] Email sending utility
- [ ] Email templates
- [ ] Password reset emails
- [ ] Welcome emails

**Checklist:**

- [ ] All middleware implemented
- [ ] Error handling working
- [ ] Validation working
- [ ] Security measures in place
- [ ] Logging configured

---

## FASE 4: Testing & Documentation (Week 5)

### 4.1 API Testing

**Unit Tests:**

- [ ] Test all controllers
- [ ] Test middleware
- [ ] Test utility functions

**Integration Tests:**

- [ ] Test all endpoints
- [ ] Test authentication flows
- [ ] Test RBAC permissions
- [ ] Test error scenarios

**Load Testing:**

- [ ] API performance testing
- [ ] Database query optimization
- [ ] Concurrent request handling

### 4.2 API Documentation

**Swagger/OpenAPI:**

- [ ] Setup Swagger documentation
- [ ] Document all endpoints
- [ ] Add request/response examples
- [ ] Add authentication documentation

**Postman Collection:**

- [ ] Create Postman collection
- [ ] Add environment variables
- [ ] Add example requests
- [ ] Export for team

**Checklist:**

- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] API documentation complete
- [ ] Postman collection ready

---

## FASE 5: Deployment (Week 6)

### 5.1 Environment Configuration

**Development:**

- [ ] Environment variables configured
- [ ] Database connection tested
- [ ] Local testing completed

**Staging:**

- [ ] Staging environment setup
- [ ] Database migration run
- [ ] API deployed to staging
- [ ] Testing on staging

**Production:**

- [ ] Production environment setup
- [ ] SSL certificates configured
- [ ] Database backups configured
- [ ] Monitoring setup
- [ ] Logging configured

### 5.2 Deployment Checklist

- [ ] Database migrations run
- [ ] Environment variables set
- [ ] API server deployed
- [ ] Health check endpoint working
- [ ] All endpoints accessible
- [ ] SSL working
- [ ] Monitoring active
- [ ] Backup strategy in place

---

## Timeline Estimasi

**Total: 6 minggu**

- Week 1: Database setup & planning
- Week 2-3: User API endpoints
- Week 3-4: Admin API endpoints
- Week 4: Middleware & utilities
- Week 5: Testing & documentation
- Week 6: Deployment

---

## Catatan Penting

1. **Admin Panel Frontend**: Akan dibuat pada fase terpisah setelah backend API selesai
2. **Flutter App Migration**: Akan dilakukan setelah backend API production-ready
3. **Real-time Features**: Untuk real-time updates, pertimbangkan WebSocket atau Server-Sent Events nanti
4. **File Storage**: Setup file storage (S3/Cloudinary) untuk upload avatar dan attachments
5. **Email Service**: Setup email service (SendGrid/AWS SES) untuk transactional emails

### To-dos

- [ ] Setup database dan create semua tables (users, transactions, budgets, admin, audit_logs)
- [ ] Implementasi user authentication (register, login, refresh token, password reset)
- [ ] Implementasi user API endpoints untuk transactions (CRUD + filters + pagination)
- [ ] Implementasi user API endpoints untuk budgets dan budget categories
- [ ] Implementasi user API endpoints untuk recurring transactions, chat messages, analytics, profile
- [ ] Implementasi admin authentication dengan RBAC (login, refresh token, permissions)
- [ ] Implementasi admin API endpoints untuk user management (list, view, create, update, delete, suspend)
- [ ] Implementasi admin API endpoints untuk transaction management dan statistics
- [ ] Implementasi admin API endpoints untuk budget management dan statistics
- [ ] Implementasi admin API endpoints untuk analytics dan reports (overview, growth, revenue)
- [ ] Implementasi admin API endpoints untuk admin management dan system settings
- [ ] Implementasi audit logging dan admin audit log endpoints
- [ ] Implementasi middleware (auth, RBAC, validation, error handling, rate limiting, security)
- [ ] Implementasi utilities (response helpers, logging, file upload, email service)
- [ ] Unit tests dan integration tests untuk semua endpoints
- [ ] Setup API documentation (Swagger/OpenAPI) dan Postman collection
- [ ] Setup deployment (Docker, CI/CD, environment configs, monitoring, backups)