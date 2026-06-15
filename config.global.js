// config.global.js
// CommunityHub - Global Community Management Platform
// Version 1.0.0

const COMMUNITYHUB_CONFIG = {
  // Supabase Configuration
  SUPABASE_URL: 'https://vorapikzttyiuhinyyyd.supabase.co',
  SUPABASE_ANON_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZvcmFwaWt6dHR5aXVoaW55eXlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEzMjYzNDEsImV4cCI6MjA5NjkwMjM0MX0.YcpSxHv31F7WDd_-R_-9my3GQo6ovbiIh297-iEE0y4',

  // App Configuration
  APP_NAME: 'CommunityHub',
  TAGLINE: 'Connect • Organize • Grow',
  DEFAULT_COMMUNITY: 'thehamilton',

  // Features
  FEATURES: {
    memberDirectory: true,
    membershipDues: true,
    announcements: true,
    voting: true,
    assetManagement: true,
    serviceRequests: true,
    financialOverview: true,
    events: true
  },

  // Regional Settings
  CURRENCY: 'USD',
  CURRENCY_SYMBOL: '$',
  DATE_FORMAT: 'MM/DD/YYYY',
  TIMEZONE: 'America/Chicago',

  // Contact
  SUPPORT_EMAIL: 'support@communityhub.app',
  SUPPORT_PHONE: '+1 (555) 123-4567'
};

// Export for use in HTML
if (typeof module !== 'undefined' && module.exports) {
  module.exports = COMMUNITYHUB_CONFIG;
}