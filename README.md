# 💰 Finance Chat App

Aplikasi keuangan pribadi berbasis Flutter dengan AI Assistant yang dapat mencatat transaksi melalui percakapan natural language. Mendukung multi-provider AI (Google Gemini, Groq, Ollama), budget tracking real-time, analytics, dan banyak lagi!

## ✨ Fitur Utama

### 🤖 AI Chat Assistant
- **Multi-Provider Support**: Gemini (Google - Gratis), Groq (Super Cepat - Gratis), Ollama (Local/Offline)
- **Natural Language Processing**: Catat transaksi dengan bahasa natural
  - Contoh: "Saya belanja 50ribu di Indomaret" → Otomatis detect expense
  - Contoh: "Terima gaji 5juta" → Otomatis detect income
- **Smart Transaction Confirmation**: Preview sebelum save
- **Chat History**: Simpan percakapan
- **Typing Indicator**: Animasi saat AI memproses

### 💳 Transaction Management
- **CRUD Lengkap**: Create, Read, Update, Delete transaksi
- **Filter & Search**: 
  - Filter by type (income/expense)
  - Search by category atau note
  - Date range filter
  - Sort by date/amount
- **Swipe to Delete**: Hapus transaksi dengan swipe
- **Pull to Refresh**: Update data terbaru

### 📊 Budget Management
- **Real-time Tracking**: Budget ter-update otomatis saat ada transaksi baru
- **Visual Progress**: 
  - Donut chart untuk overview
  - Progress bar per category
  - Daily & weekly budget calculator
- **Budget Alerts**:
  - Warning saat 80% budget terpakai
  - Danger saat 90% budget terpakai  
  - Error saat over budget
- **Category Allocation**: Atur budget per kategori dengan persentase

### 📈 Analytics
- **Pie Charts**: Breakdown expense & income by category
- **Summary Cards**: Total income, expense, balance
- **Budget Overview**: Visualisasi budget harian & mingguan
- **Color-coded Indicators**: Hijau (aman), kuning (warning), merah (bahaya)

### 👤 Profile Management
- **User Info**: Nama, email, foto profil
- **Edit Profile**: Update nama dan foto
- **Statistics**: 
  - Total transaksi
  - Total income & expense
  - Balance
  - Member since date

### ⚙️ Settings
- **Bahasa**: Indonesia & English
- **Tema**: Light, Dark, Auto (follow system)
- **AI Configuration**:
  - Pilih provider (Gemini/Groq/Ollama)
  - Input API Key (secure storage)
  - Server URL untuk Ollama
- **Notifications**: Toggle untuk reminder & alerts

### 🔒 Security
- **Encrypted Storage**: API Keys disimpan dengan secure storage
- **Firebase Auth**: Login & Register dengan email/password
- **Input Validation**: Validasi di semua form input

### 🎨 UI/UX Modern
- **Material Design 3**: Design system modern
- **Custom Widgets**: Reusable components
- **Smooth Animations**: Transitions & loading states
- **Responsive**: Tampilan bagus di berbagai ukuran layar
- **Empty States**: Informative empty states dengan call-to-action

## 🚀 Cara Memulai

### Prerequisites
- Flutter SDK 3.9.0 atau lebih baru
- Firebase project (untuk Auth & Database)
- API Key dari salah satu provider:
  - **Google Gemini** (Recommended): https://makersuite.google.com/app/apikey
  - **Groq** (Fastest): https://console.groq.com
  - **Ollama** (Local): Install dari https://ollama.ai

### Installation

1. Clone repository:
```bash
git clone <repository-url>
cd finance_chat_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Setup Firebase:
   - Buat project di Firebase Console
   - Download `google-services.json` (Android) dan taruh di `android/app/`
   - Download `GoogleService-Info.plist` (iOS) dan taruh di `ios/Runner/`
   - Run: `flutterfire configure`

4. Run app:
```bash
flutter run
```

## 📱 Cara Penggunaan

### 1. Setup AI (Pertama Kali)

#### Opsi A: Google Gemini (Recommended)
1. Buka **Settings** dari home screen
2. Pilih **AI Provider**: Google Gemini
3. Dapatkan API Key gratis:
   - Buka: https://makersuite.google.com/app/apikey
   - Login dengan Google Account
   - Klik "Create API Key"
   - Copy API Key
4. Paste API Key di Settings
5. Klik "Simpan API Key"

#### Opsi B: Groq (Tercepat)
1. Buka **Settings**
2. Pilih **AI Provider**: Groq
3. Dapatkan API Key:
   - Buka: https://console.groq.com
   - Sign up/Login
   - Create API Key
4. Paste API Key di Settings
5. Klik "Simpan API Key"

#### Opsi C: Ollama (Local/Offline)
1. Install Ollama di komputer: https://ollama.ai
2. Run Ollama server:
   ```bash
   ollama serve
   ```
3. Download model:
   ```bash
   ollama pull llama3.2
   ```
4. Buka Settings di app
5. Pilih **AI Provider**: Ollama
6. Server URL default: `http://localhost:11434` (atau IP komputer jika dari HP)

### 2. Catat Transaksi Via Chat

1. Buka tab **Chat**
2. Ketik pesan natural:
   - "Saya makan siang 35ribu"
   - "Bayar parkir 5rb"
   - "Terima gaji 5juta"
   - "Belanja bulanan di supermarket 500rb"
3. AI akan mendeteksi dan meminta konfirmasi
4. Review transaksi, lalu klik **Simpan**

### 3. Catat Transaksi Manual

1. Ke tab **Analytics**
2. Klik tombol **Transaksi** (floating button)
3. Klik tombol **Tambah** (+)
4. Isi form:
   - Pilih tipe (Pemasukan/Pengeluaran)
   - Input jumlah
   - Pilih kategori
   - Pilih tanggal
   - Tambah catatan (optional)
5. Klik **Simpan**

### 4. Kelola Transaksi

Di **Transaction List Screen**:
- **Search**: Ketik di search bar
- **Filter**: Klik icon filter (⋮) untuk filter by type, sort, date range
- **Edit**: Tap pada transaksi untuk edit
- **Delete**: Swipe ke kiri untuk hapus

### 5. Setup Budget

1. Ke tab **Analytics**
2. Klik **Buat Budget**
3. Input monthly income
4. Tambah kategori dengan persentase:
   - Food: 30%
   - Transport: 20%
   - Shopping: 15%
   - dst...
5. Total harus 100%
6. Klik **Save Budget**

### 6. Monitor Budget

Budget akan otomatis ter-update setiap ada transaksi baru:
- **Hijau**: Budget aman (< 80%)
- **Kuning**: Warning (80-90%)
- **Merah**: Danger/Over budget (> 90%)

Budget card menampilkan:
- Total budget vs terpakai
- Sisa budget
- Daily budget
- Weekly budget
- Progress per category

### 7. Lihat Analytics

Tab **Analytics** menampilkan:
- Total Income & Expense
- Balance
- Pie charts (breakdown by category)
- Budget overview
- Budget per category

## 🛠️ Tech Stack

- **Framework**: Flutter 3.9+
- **Language**: Dart
- **State Management**: Provider
- **Database**: Firebase Realtime Database
- **Authentication**: Firebase Auth
- **Storage**: SharedPreferences, FlutterSecureStorage
- **AI**: Google Gemini, Groq, Ollama
- **Charts**: FL Chart
- **Localization**: Easy Localization
- **Notifications**: Flutter Local Notifications

## 📁 Project Structure

```
lib/
├── main.dart                    # Entry point
├── firebase_options.dart        # Firebase configuration
├── models/                      # Data models
│   ├── transaction.dart
│   ├── budget.dart
│   ├── category.dart
│   ├── chat_message.dart
│   └── user_settings.dart
├── screens/                     # UI Screens
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   ├── profile_screen.dart
│   ├── settings_screen.dart
│   ├── transaction_list_screen.dart
│   ├── transaction_form_screen.dart
│   └── budget_planner_screen.dart
├── services/                    # Business logic
│   ├── ai_service_interface.dart
│   ├── gemini_service.dart     # Google Gemini AI
│   ├── groq_service.dart       # Groq AI
│   ├── ollama_service.dart     # Ollama local AI
│   ├── ai_factory.dart
│   ├── database_service.dart   # Firebase CRUD
│   ├── budget_service.dart
│   ├── notification_service.dart
│   └── secure_storage_service.dart
├── providers/                   # State management
│   ├── theme_provider.dart
│   └── settings_provider.dart
├── widgets/                     # Reusable components
│   ├── chat_bubble.dart
│   ├── typing_indicator.dart
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── transaction_card.dart
│   ├── budget_overview_card.dart
│   ├── empty_state.dart
│   └── loading_overlay.dart
└── utils/                       # Utilities
    ├── theme.dart
    ├── constants.dart
    ├── validators.dart
    ├── formatters.dart
    └── helpers.dart
```

## 🎯 Fitur Yang Sudah Selesai

### ✅ Phase 1 - Foundation (100%)
- [x] Design System modern (theme, colors, typography)
- [x] Custom Widgets reusable
- [x] Secure Storage untuk API Keys
- [x] Settings Screen lengkap
- [x] Profile Screen dengan statistics

### ✅ Phase 2 - Core Features (100%)
- [x] Multi AI Provider Support (Gemini, Groq, Ollama)
- [x] Enhanced Chat UI (bubble chat, typing indicator)
- [x] Smart Parsing transaksi dari natural language
- [x] Transaction CRUD lengkap (filter, search, sort)
- [x] Budget Management dengan real-time tracking
- [x] Budget Alert System

### ✅ Phase 3 - Advanced Features (50%)
- [x] Enhanced Budget Management
- [x] Budget Alerts dengan color indicators
- [x] Notification System (service created)
- [ ] Enhanced Analytics (multiple chart types)
- [ ] Export/Import Data (CSV, PDF)
- [ ] Recurring Transactions

### ⏳ Phase 4 - Polish (0%)
- [ ] Onboarding Experience
- [ ] Performance Optimization
- [ ] Advanced Analytics
- [ ] Category Management with custom icons

## 📊 Progress: ~75% Complete

Aplikasi sudah **FULLY FUNCTIONAL** untuk penggunaan sehari-hari! 🎉

## 🐛 Troubleshooting

### AI Tidak Merespon
- Pastikan API Key sudah correct
- Check koneksi internet
- Untuk Ollama: Pastikan server running (`ollama serve`)

### Firebase Error
- Pastikan `google-services.json` sudah ada
- Check Firebase Rules
- Verify Firebase project configuration

### Notification Tidak Muncul
- Grant permission untuk notifications (iOS)
- Check notification settings di Settings screen

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## 📝 License

This project is open source and available under the MIT License.

## 👨‍💻 Developer

Developed with ❤️ using Flutter

---

**Happy Tracking! 💰📊**
