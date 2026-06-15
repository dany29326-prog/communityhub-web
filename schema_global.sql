-- ============================================
-- COMMUNITYHUB GLOBAL - TABEL STRUKTUR
-- Untuk HOA, Residential Communities, Membership Orgs
-- ============================================

-- 1. MEMBERS (dulu: warga)
CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(50),
  address TEXT,
  unit_number VARCHAR(50),
  move_in_date DATE,
  status VARCHAR(50) DEFAULT 'active', -- active, inactive, moved_out
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. BOARD MEMBERS (dulu: pengurus_rt)
CREATE TABLE board_members (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  position VARCHAR(100) NOT NULL, -- President, Treasurer, Secretary, etc.
  display_order INT DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. MEMBERSHIP DUES (dulu: iuran)
CREATE TABLE membership_dues (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  due_month DATE NOT NULL, -- First day of month: '2024-01-01'
  amount DECIMAL(12,2) NOT NULL,
  paid_amount DECIMAL(12,2) DEFAULT 0,
  status VARCHAR(50) DEFAULT 'unpaid', -- unpaid, partial, paid
  payment_date DATE,
  payment_method VARCHAR(50),
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. TREASURY / FINANCIAL (dulu: kas)
CREATE TABLE treasury (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  transaction_date DATE NOT NULL,
  description TEXT NOT NULL,
  type VARCHAR(50) NOT NULL, -- income, expense
  amount DECIMAL(12,2) NOT NULL,
  category VARCHAR(100),
  receipt_url TEXT,
  created_by INT, -- member_id
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. ANNOUNCEMENTS (dulu: pengumuman)
CREATE TABLE announcements (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  category VARCHAR(50) DEFAULT 'general', -- general, urgent, event
  is_pinned BOOLEAN DEFAULT false,
  published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. EVENTS (dulu: agenda)
CREATE TABLE events (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  event_date DATE NOT NULL,
  event_time VARCHAR(50),
  location VARCHAR(255),
  category VARCHAR(50), -- meeting, social, maintenance, security
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 7. VOTING / POLLS (dulu: polling)
CREATE TABLE polls (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  question TEXT NOT NULL,
  options JSONB NOT NULL, -- ['Yes', 'No', 'Abstain']
  status VARCHAR(50) DEFAULT 'active', -- active, closed
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  closed_at TIMESTAMP WITH TIME ZONE
);

-- 8. POLL VOTES (dulu: polling_vote)
CREATE TABLE poll_votes (
  id SERIAL PRIMARY KEY,
  poll_id INT REFERENCES polls(id) ON DELETE CASCADE,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  choice VARCHAR(255) NOT NULL,
  voted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(poll_id, member_id)
);

-- 9. SERVICE REQUESTS (dulu: pengajuan_surat)
CREATE TABLE service_requests (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  request_type VARCHAR(100) NOT NULL, -- maintenance, document, complaint, etc.
  subject VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  status VARCHAR(50) DEFAULT 'pending', -- pending, approved, rejected, completed
  admin_notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  resolved_at TIMESTAMP WITH TIME ZONE
);

-- 10. ASSETS / INVENTORY (dulu: inventaris)
CREATE TABLE community_assets (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  asset_name VARCHAR(255) NOT NULL,
  description TEXT,
  total_quantity INT DEFAULT 1,
  available_quantity INT DEFAULT 1,
  location VARCHAR(255),
  condition VARCHAR(50) DEFAULT 'good', -- good, needs_repair, damaged
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 11. ASSET LOANS (dulu: inventaris_pinjam)
CREATE TABLE asset_loans (
  id SERIAL PRIMARY KEY,
  asset_id INT REFERENCES community_assets(id) ON DELETE CASCADE,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  quantity INT DEFAULT 1,
  loan_date DATE NOT NULL,
  expected_return_date DATE,
  actual_return_date DATE,
  status VARCHAR(50) DEFAULT 'pending', -- pending, approved, borrowed, returned, rejected
  purpose TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 12. COMMUNITIES (dulu: rts)
CREATE TABLE communities (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  subdomain VARCHAR(100) UNIQUE NOT NULL,
  logo_url TEXT,
  primary_color VARCHAR(7) DEFAULT '#059669',
  address TEXT,
  contact_email VARCHAR(255),
  contact_phone VARCHAR(50),
  settings JSONB DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 13. COMMUNITY MEMBERS (user management) - opsional, untuk auth
CREATE TABLE community_members (
  id SERIAL PRIMARY KEY,
  community_id INT REFERENCES communities(id) ON DELETE CASCADE,
  user_email VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'member', -- admin, board, member
  member_id INT REFERENCES members(id),
  invited_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  joined_at TIMESTAMP WITH TIME ZONE,
  UNIQUE(community_id, user_email)
);

-- ============================================
-- INDEXES untuk performa
-- ============================================
CREATE INDEX idx_members_community ON members(community_id);
CREATE INDEX idx_dues_member ON membership_dues(member_id);
CREATE INDEX idx_dues_month ON membership_dues(due_month);
CREATE INDEX idx_treasury_date ON treasury(transaction_date);
CREATE INDEX idx_announcements_published ON announcements(published_at);
CREATE INDEX idx_events_date ON events(event_date);
CREATE INDEX idx_service_requests_status ON service_requests(status);
CREATE INDEX idx_asset_loans_status ON asset_loans(status);