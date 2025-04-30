# 🧾 GST Billing App (Flutter)

A Flutter-based GST Billing App developed for **TATA Retail Solutions** to simplify invoice generation, automate GST calculations, and maintain transaction history. This project helps eliminate manual billing errors and improves cashier efficiency while ensuring compliance with Indian GST regulations.

---

## 📱 Features

✅ Add products with name, price, and applicable GST rate (5%, 12%, 18%, 28%)  
✅ Auto-calculation of CGST and SGST  
✅ Real-time total price computation  
✅ Itemized billing with quantity handling  
✅ Persistent data storage using Hive  
✅ Clean and intuitive UI for fast billing operations  

---

## 🧮 GST Calculation Logic

For each product:

**yaml file:**

Example for ₹100 item with 18% GST:  
- CGST: ₹9  
- SGST: ₹9  
- Total: ₹118  

---

## 🗃️ Tech Stack

- **Flutter** – Frontend framework  
- **Dart** – Programming language  
- **Hive** – Lightweight NoSQL database for local storage  
- **path_provider** – For locating device directories

---

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK installed
- Android Studio / VS Code
- Emulator or physical device

### Steps

```bash
git clone https://github.com/yourusername/gst-billing-app.git
cd gst-billing-app
flutter pub get
flutter packages pub run build_runner build
flutter run
