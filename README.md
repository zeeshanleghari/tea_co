# 🍵 Tea Co.

**Tea Co.** is a modern Flutter e-commerce app for browsing and ordering organic teas & coffees. It features a clean onboarding flow, Supabase-powered authentication, a searchable product catalog, and a full cart-to-checkout ordering experience.

---

## ✨ Features

- 🎬 **Animated Splash Screen** — branded intro with smooth transitions
- 🔐 **Authentication** — login, sign up, and form validation powered by Supabase
- 🏠 **Home Dashboard** — personalized greeting, special offers, and popular products
- 📚 **Catalog & Categories** — browse by category (Traditional Teas, Hot Coffees, etc.) with live search
- 🛒 **Cart Management** — add/remove items, adjust quantities, view running total
- 📦 **Checkout Flow** — delivery details form with validation
- ✅ **Order Confirmation** — success screen with order summary
- 👤 **Profile Management** — view account details and logout

---

## 📱 Screenshots

| Splash Screen | Home | Login | Sign Up |
|:---:|:---:|:---:|:---:|
| ![Splash](screenshots/01_splash_screen.png) | ![Home](screenshots/02_home_screen.png) | ![Login](screenshots/04_login_screen.png) | ![Signup](screenshots/05_signup_screen.png) |

| Home (Logged In) | Profile | Catalog | Catalog Search |
|:---:|:---:|:---:|:---:|
| ![Home Logged In](screenshots/07_home_loggedin_screen.png) | ![Profile](screenshots/08_profile_screen.png) | ![Catalog](screenshots/09_catalog_categories_screen.png) | ![Search](screenshots/12_catalog_search_screen.png) |

| Product Detail | Cart | Checkout | Order Success |
|:---:|:---:|:---:|:---:|
| ![Product Detail](screenshots/11_product_detail_screen.png) | ![Cart](screenshots/13_cart_screen.png) | ![Checkout](screenshots/15_checkout_filled_screen.png) | ![Success](screenshots/16_order_success_screen.png) |

<details>
<summary>📷 View all screenshots</summary>

| | | |
|:---:|:---:|:---:|
| ![](screenshots/01_splash_screen.png) | ![](screenshots/02_home_screen.png) | ![](screenshots/03_login_prompt_screen.png) |
| ![](screenshots/04_login_screen.png) | ![](screenshots/05_signup_screen.png) | ![](screenshots/06_login_error_screen.png) |
| ![](screenshots/07_home_loggedin_screen.png) | ![](screenshots/08_profile_screen.png) | ![](screenshots/09_catalog_categories_screen.png) |
| ![](screenshots/10_catalog_filtered_screen.png) | ![](screenshots/11_product_detail_screen.png) | ![](screenshots/12_catalog_search_screen.png) |
| ![](screenshots/13_cart_screen.png) | ![](screenshots/14_checkout_delivery_screen.png) | ![](screenshots/15_checkout_filled_screen.png) |
| ![](screenshots/16_order_success_screen.png) | | |

</details>

---

## 🛠️ Tech Stack

- **[Flutter](https://flutter.dev)** — cross-platform UI framework
- **[Supabase](https://supabase.com)** (`supabase_flutter`) — authentication & backend
- **`google_nav_bar`** — bottom navigation bar
- **`shared_preferences`** — local storage
- **`splash_master`** — native splash screen generation
- **`flutter_animate`** — UI animations
- **`flutter_launcher_icons`** — app icon generation

**Platforms:** Android · iOS · Web · Windows

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.12.2`)
- A [Supabase](https://supabase.com) project (URL + anon key)

### Installation

```bash
# Clone the repository
git clone https://github.com/zeeshanleghari/tea_co.git
cd tea_co

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Supabase Setup
Add your Supabase project credentials (URL and anon key) wherever the app initializes Supabase (e.g. in `main.dart` or an `.env` file), then re-run the app.

---

## 📂 Project Structure

```
tea_co/
├── android/          # Android platform files
├── ios/               # iOS platform files
├── web/               # Web platform files
├── windows/           # Windows platform files
├── lib/               # App source code (screens, widgets, assets)
├── test/              # Unit & widget tests
├── pubspec.yaml       # Dependencies & app metadata
└── README.md
```

---

