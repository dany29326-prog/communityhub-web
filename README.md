# CommunityHub 🏡

**CommunityHub** is a modern, serverless, single-page web application (SPA) designed to streamline and elevate the management of residential communities, HOAs (Homeowner Associations), and modern neighborhoods. 

Built with a focus on **Pixel-Perfect UI**, **Zero-Friction UX**, and **Real-Time Data**, CommunityHub serves as a centralized digital portal for both residents and community administrators.

## ✨ Key Features

### For Residents (Public Portal)
* **Real-Time Community Dashboard:** View live statistics on engaged households, treasury balance, and upcoming events.
* **Dynamic Community Feed:** Stay updated with the latest announcements (Info, Urgent, Events).
* **Facility Reservations:** Book shared amenities (e.g., clubhouse, pool) with instant availability checking.
* **Interactive Polling:** Participate in community decisions through secure, real-time voting.
* **Service Requests:** Seamlessly report issues or request maintenance.
* **Mobile-First Design:** Fully responsive layout with an intuitive bottom navigation bar and elegant Dark Mode support.

### For Administrators (Secure Admin Panel)
* **Resident Directory:** Manage household records and membership statuses.
* **Treasury & Dues Management:** Track monthly dues, record income/expenses, and visualize financial health.
* **Hybrid Media Management:** Built-in client-side image compression (Canvas API) coupled with Supabase Storage for highly optimized, cost-effective media uploads.
* **Asset & Loan Tracking:** Keep track of community inventory and manage loan requests from residents.
* **Board Member Directory:** Showcase the organizational structure of the community leaders.

## 🛠 Technology Stack

* **Frontend:** Vanilla HTML5, CSS3 (Custom Variables, Flexbox/Grid), and Modern JavaScript (ES6+).
* **Backend as a Service (BaaS):** [Supabase](https://supabase.com/) (PostgreSQL Database, Authentication, and Storage).
* **Icons:** [Lucide Icons](https://lucide.dev/) for crisp, scalable vector graphics.
* **Architecture:** Monolithic Single-Page Application (SPA) architecture utilizing client-side DOM swapping for lightning-fast page transitions without browser reloads.

## 🚀 Getting Started

CommunityHub is entirely client-side, making deployment incredibly simple. It can be hosted on any static hosting provider (GitHub Pages, Vercel, Netlify).

### Prerequisites
1. An active [Supabase](https://supabase.com/) project.
2. A database populated with the schema provided in `schema_global.sql`.
3. A public storage bucket named `public_images` configured in Supabase.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/communityhub-web.git
   ```
2. Link your Supabase instance by updating the credentials in `config.global.js` or directly inside the main `index.html` file where the Supabase client is initialized.
3. Open `index.html` in any modern web browser or serve it using a local development server.

## 🤝 Contribution

This project was built to empower communities. Contributions, issues, and feature requests are welcome!

---
*Built with ❤️ for modern living.*
