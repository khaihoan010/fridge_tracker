# Fridge Tracker - Detailed Wireframes
## Screen-by-Screen Design Specifications

---

## 1. HOME SCREEN (home_screen.dart)

### Overall Layout
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ╔═══════════════════════════════╗ ┃  Status Bar
┃ ║  Gradient Header (Pink→Lav)  ║ ┃
┃ ║                               ║ ┃
┃ ║  🧊  Tủ Lạnh Của Tôi    ⚙️   ║ ┃  56dp height
┃ ║                               ║ ┃
┃ ║  ┌─────────────────────────┐ ║ ┃
┃ ║  │ 🔍  Tìm kiếm...        │ ║ ┃  Search: 48dp
┃ ║  └─────────────────────────┘ ║ ┃
┃ ║                               ║ ┃
┃ ╚═══════════════════════════════╝ ┃
┃ ┌─────┬─────┬─────┬─────┐       ┃
┃ │Tất  │Còn  │Sắp  │Hết  │       ┃  Tab Bar: 48dp
┃ │cả 12│hạn 8│hết 3│hạn 1│       ┃
┃ └─────┴─────┴─────┴─────┘       ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                   ┃
┃  ⟨ 🥬 🍎 🥩 🐟 🥛 🥤 🧊 ... ⟩    ┃  Category Filter
┃                                   ┃  Horizontal scroll
┃───────────────────────────────────┃
┃                                   ┃
┃  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ ┃
┃  ┃ ┌────┐                    ┃ ┃  Food Card
┃  ┃ │Img │  Cà chua           ┃ ┃  Height: 96dp
┃  ┃ │🍅  │  🥬 Rau củ          ┃ ┃  Padding: 12dp
┃  ┃ │    │  📍 Tủ lạnh        ┃ ┃  Margin: 8dp h, 8dp v
┃  ┃ └────┘  ⏰ Còn 5 ngày  ✨ ┃ ┃  Border radius: 20dp
┃  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ┃
┃                                   ┃
┃  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ ┃
┃  ┃ ┌────┐                    ┃ ┃
┃  ┃ │Img │  Sữa tươi          ┃ ┃
┃  ┃ │🥛  │  🥛 Sữa & Trứng     ┃ ┃
┃  ┃ │    │  📍 Tủ lạnh        ┃ ┃
┃  ┃ └────┘  ⏰ Còn 2 ngày  ⚠️ ┃ ┃
┃  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ┃
┃                                   ┃
┃  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ ┃
┃  ┃ ┌────┐                    ┃ ┃
┃  ┃ │Img │  Thịt bò           ┃ ┃
┃  ┃ │🥩  │  🥩 Thịt            ┃ ┃
┃  ┃ │    │  📍 Tủ đông        ┃ ┃
┃  ┃ └────┘  ⏰ Hết hạn hôm qua ❌ ┃
┃  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ┃
┃                                   ┃
┃                                   ┃
┃                            ╔═══╗  ┃  FAB
┃                            ║ + ║  ┃  56x56dp
┃                            ╚═══╝  ┃  Gradient shadow
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### Component Breakdown

#### 1.1 Header Section (Gradient AppBar)
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFFB6C1), Color(0xFFE6E6FA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: SafeArea(
    child: Column(
      children: [
        // Title Bar
        Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.kitchen, color: Colors.white),
              ),
              SizedBox(width: 12),
              // Title
              Text(
                'Tủ Lạnh Của Tôi',
                style: GoogleFonts.quicksand(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              // Settings Button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm thực phẩm...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Color(0xFFFFB6C1)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
)
```

#### 1.2 Tab Bar
```dart
Container(
  color: Colors.white,
  child: TabBar(
    tabs: [
      _buildTab('Tất cả', 12, Colors.grey[700]!),
      _buildTab('Còn hạn', 8, Color(0xFF98D8C8)),
      _buildTab('Sắp hết', 3, Color(0xFFFFB88C)),
      _buildTab('Hết hạn', 1, Color(0xFFFF9999)),
    ],
    indicatorColor: Color(0xFFFFB6C1),
    indicatorWeight: 3,
    labelColor: Color(0xFFFFB6C1),
    unselectedLabelColor: Colors.grey,
  ),
)

Widget _buildTab(String label, int count, Color color) {
  return Tab(
    height: 64,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}
```

#### 1.3 Category Filter (Horizontal Scroll)
```dart
Container(
  height: 64,
  color: Colors.white,
  child: ListView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    children: [
      _buildCategoryChip('Tất cả', Icons.apps, true),
      _buildCategoryChip('Rau củ', Icons.eco, false),
      _buildCategoryChip('Trái cây', Icons.apple, false),
      _buildCategoryChip('Thịt', Icons.set_meal, false),
      _buildCategoryChip('Hải sản', Icons.phishing, false),
      // ... more
    ],
  ),
)

Widget _buildCategoryChip(String label, IconData icon, bool selected) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    child: Material(
      color: selected
          ? Color(0xFFFFB6C1)
          : Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: selected ? 4 : 0,
      shadowColor: Color(0xFFFFB6C1).withOpacity(0.3),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.transparent : Colors.grey[300]!,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? Colors.white : Colors.grey[700],
              ),
              SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
```

#### 1.4 Food Card (Enhanced Design)
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Image with overlay badge
            Stack(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFB6C1).withOpacity(0.2),
                        Color(0xFFE6E6FA).withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                    // Or icon if no image:
                    // child: Icon(categoryIcon, size: 36, color: categoryColor),
                  ),
                ),
                // Priority badge (if expiring soon)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFB88C),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFFB88C).withOpacity(0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.priority_high,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    'Cà chua',
                    style: GoogleFonts.quicksand(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),

                  // Category & Location
                  Row(
                    children: [
                      Icon(Icons.eco, size: 14, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'Rau củ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.kitchen, size: 14, color: Colors.grey[500]),
                      SizedBox(width: 4),
                      Text(
                        'Tủ lạnh',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Expiry info with badge
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 4),
                      Text(
                        'HSD: 15/02/2025',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      // Status badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF98D8C8),
                              Color(0xFF7CC9B5),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF98D8C8).withOpacity(0.3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '✨',
                              style: TextStyle(fontSize: 11),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Còn 5 ngày',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
```

#### 1.5 Empty State
```dart
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Illustration
      Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFFFFB6C1).withOpacity(0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: Center(
          child: Text(
            '🧊',
            style: TextStyle(fontSize: 100),
          ),
        ),
      ),
      SizedBox(height: 24),

      // Message
      Text(
        'Tủ lạnh trống trơn',
        style: GoogleFonts.quicksand(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Text(
          'Hãy thêm thực phẩm đầu tiên của bạn để bắt đầu quản lý tủ lạnh nhé! 💕',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[500],
            height: 1.5,
          ),
        ),
      ),
      SizedBox(height: 32),

      // CTA Button
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFB6C1).withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Thêm thực phẩm',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  ),
)
```

#### 1.6 FAB (Floating Action Button)
```dart
Container(
  width: 56,
  height: 56,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFFFB6C1).withOpacity(0.5),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(28),
      child: Center(
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    ),
  ),
)

// Extended version when scrolling up
Container(
  height: 56,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
    ),
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFFFB6C1).withOpacity(0.5),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'Thêm mới',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
```

---

## 2. ADD/EDIT FOOD SCREEN (add_food_screen.dart)

### Overall Layout
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ⬅️  Thêm Thực Phẩm           ✓ Lưu ┃  App Bar
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                     ┃
┃  ╔═══════════════════════════════╗ ┃
┃  ║                               ║ ┃
┃  ║        ┌───────────┐         ║ ┃  Image Section
┃  ║        │           │         ║ ┃  200x200dp
┃  ║        │  📸       │         ║ ┃  Gradient border
┃  ║        │  Thêm ảnh │         ║ ┃  when empty
┃  ║        └───────────┘         ║ ┃
┃  ║                               ║ ┃
┃  ╚═══════════════════════════════╝ ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  📝 Thông tin cơ bản               ┃  Section Header
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Text Field
┃  │ 🏷️  Tên thực phẩm *         │  ┃  56dp height
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Dropdown
┃  │ 🗂️  Danh mục         ▼     │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Dropdown
┃  │ 📍  Vị trí lưu trữ    ▼     │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  🔢 Số lượng                       ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌────────────────┐ ┌──────────┐  ┃  Split inputs
┃  │ ➕ Số lượng   │ │ Đơn vị ▼│  ┃
┃  └────────────────┘ └──────────┘  ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  📅 Ngày tháng                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Date Picker
┃  │ 🛒  Ngày mua    15/02/2025 📆│  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Date Picker
┃  │ ⏰  Hạn sử dụng  25/02/2025 📆│  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  📷 Thêm thông tin                 ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Scan Button
┃  │ 📱  Quét mã vạch         🔍 │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃  Text Area
┃  │ 📝  Ghi chú (không bắt buộc)│  ┃  Multi-line
┃  │                             │  ┃  Min 3 lines
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃                                     ┃  Bottom padding
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### Component Breakdown

#### 2.1 App Bar
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: SafeArea(
    child: Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // Back button
          Container(
            width: 40,
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, size: 20),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 8),
          // Title
          Text(
            'Thêm Thực Phẩm',
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Spacer(),
          // Save button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.check_rounded, color: Colors.white, size: 18),
                SizedBox(width: 4),
                Text(
                  'Lưu',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
)
```

#### 2.2 Image Upload Section
```dart
Center(
  child: GestureDetector(
    onTap: () => _showImagePicker(),
    child: Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFB6C1).withOpacity(0.1),
            Color(0xFFE6E6FA).withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: Color(0xFFFFB6C1).withOpacity(0.3),
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: _imagePath == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB6C1).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 32,
                    color: Color(0xFFFFB6C1),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Thêm ảnh',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFB6C1),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Chạm để chọn',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.file(
                    File(_imagePath!),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => setState(() => _imagePath = null),
                    ),
                  ),
                ),
              ],
            ),
    ),
  ),
)
```

#### 2.3 Section Header
```dart
Widget _buildSectionHeader(String emoji, String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
    child: Row(
      children: [
        Text(
          emoji,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFB6C1).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
```

#### 2.4 Cute Text Field
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Color(0xFFFFFBF5),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: _isFocused ? Color(0xFFFFB6C1) : Colors.transparent,
      width: 2,
    ),
    boxShadow: _isFocused
        ? [
            BoxShadow(
              color: Color(0xFFFFB6C1).withOpacity(0.2),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ]
        : [],
  ),
  child: TextField(
    controller: _nameController,
    style: GoogleFonts.poppins(
      fontSize: 15,
      color: Colors.grey[800],
    ),
    decoration: InputDecoration(
      labelText: 'Tên thực phẩm *',
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[600],
      ),
      floatingLabelStyle: GoogleFonts.poppins(
        fontSize: 12,
        color: Color(0xFFFFB6C1),
        fontWeight: FontWeight.w600,
      ),
      prefixIcon: Container(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.fastfood_rounded,
          color: Color(0xFFFFB6C1),
          size: 22,
        ),
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  ),
)
```

#### 2.5 Cute Dropdown
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Color(0xFFFFFBF5),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.transparent,
      width: 2,
    ),
  ),
  child: DropdownButtonFormField<String>(
    value: _selectedCategory,
    decoration: InputDecoration(
      labelText: 'Danh mục',
      labelStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
      prefixIcon: Container(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.category_rounded,
          color: Color(0xFFFFB6C1),
          size: 22,
        ),
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[600]),
    items: FoodCategory.defaultCategories.map((cat) {
      return DropdownMenuItem(
        value: cat.id,
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: cat.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(cat.icon, size: 18, color: cat.color),
            ),
            SizedBox(width: 12),
            Text(
              cat.name,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) setState(() => _selectedCategory = value);
    },
    dropdownColor: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
)
```

#### 2.6 Date Picker Card
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Color(0xFFFFFBF5),
    borderRadius: BorderRadius.circular(16),
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => _selectDate(context),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFFFB6C1).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                color: Color(0xFFFFB6C1),
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngày mua',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    DateFormat('dd/MM/yyyy').format(_purchaseDate),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    ),
  ),
)
```

#### 2.7 Barcode Scan Button
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFE6E6FA),
        Color(0xFFDDA0DD),
      ],
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFE6E6FA).withOpacity(0.4),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => _scanBarcode(),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                _barcode ?? 'Quét mã vạch',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Icon(
              Icons.camera_alt_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    ),
  ),
)
```

---

## 3. FOOD DETAIL SCREEN (food_detail_screen.dart)

### Overall Layout
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                     ┃
┃  ╔═══════════════════════════════╗ ┃
┃  ║                               ║ ┃
┃  ║         Hero Image            ║ ┃  250dp height
┃  ║         (Full width)          ║ ┃  Gradient overlay
┃  ║                               ║ ┃  at bottom
┃  ║  ⬅️                       ✏️  ║ ┃  Back & Edit
┃  ║                               ║ ┃  buttons
┃  ╚═══════════════════════════════╝ ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │     🍅 Cà chua tươi         │  ┃  Title Card
┃  │                             │  ┃  Overlap with
┃  │   ┏━━━━━━━━━━━━━━━━━━━┓   │  ┃  hero image
┃  │   ┃ ✨ Còn hạn        ┃   │  ┃  Status Badge
┃  │   ┃ Còn 5 ngày        ┃   │  ┃
┃  │   ┗━━━━━━━━━━━━━━━━━━━┛   │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  📋 Thông tin chi tiết              ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────┐  ┌─────────────┐ ┃
┃  │ 🗂️ Danh mục │  │ 📍 Vị trí   │ ┃  Info Grid
┃  │             │  │             │ ┃  2 columns
┃  │  Rau củ     │  │  Tủ lạnh    │ ┃
┃  └─────────────┘  └─────────────┘ ┃
┃                                     ┃
┃  ┌─────────────┐  ┌─────────────┐ ┃
┃  │ 📊 Số lượng │  │ 🛒 Ngày mua │ ┃
┃  │             │  │             │ ┃
┃  │  2 kg       │  │  15/02/2025 │ ┃
┃  └─────────────┘  └─────────────┘ ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ 📝 Ghi chú                  │  ┃  Notes Card
┃  │                             │  ┃  Full width
┃  │ Mua ở siêu thị, còn        │  ┃
┃  │ tươi ngon...                │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ 📊 Thống kê                 │  ┃  Stats Card
┃  │                             │  ┃
┃  │ • Đã lưu trữ: 5 ngày        │  ┃
┃  │ • Còn lại: 5 ngày           │  ┃
┃  │ • Tiêu thụ: 50%             │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ╔═══════════════════════════════╗ ┃
┃  ║  [  🗑️ Xóa  ]  [  ✏️ Sửa  ]  ║ ┃  Action Bar
┃  ╚═══════════════════════════════╝ ┃  Fixed bottom
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### Component Breakdown

#### 3.1 Hero Image with Overlay
```dart
Stack(
  children: [
    // Image
    Container(
      height: 250,
      width: double.infinity,
      child: Image.file(
        File(food.imagePath!),
        fit: BoxFit.cover,
      ),
    ),

    // Gradient overlay
    Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.6),
          ],
          stops: [0.5, 1.0],
        ),
      ),
    ),

    // Top buttons
    SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Back button
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Spacer(),
            // Edit button
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.edit_rounded, size: 18),
                color: Color(0xFFFFB6C1),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)
```

#### 3.2 Title Card with Status Badge
```dart
Transform.translate(
  offset: Offset(0, -30),
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        // Title
        Text(
          'Cà chua tươi',
          style: GoogleFonts.quicksand(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),

        // Large status badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF98D8C8), Color(0xFF7CC9B5)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF98D8C8).withOpacity(0.4),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('✨', style: TextStyle(fontSize: 24)),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Còn hạn',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Còn 5 ngày',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
)
```

#### 3.3 Info Card (Grid Item)
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFFFFBF5),
        Color(0xFFFFF8F0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Color(0xFFFFB6C1).withOpacity(0.2),
      width: 1,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Icon
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFFFFB6C1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.category_rounded,
          color: Color(0xFFFFB6C1),
          size: 20,
        ),
      ),
      SizedBox(height: 12),

      // Label
      Text(
        'Danh mục',
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
      SizedBox(height: 4),

      // Value
      Text(
        'Rau củ',
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    ],
  ),
)
```

#### 3.4 Action Bar (Bottom)
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0, -5),
      ),
    ],
  ),
  child: SafeArea(
    child: Row(
      children: [
        // Delete button
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFFF9999), width: 2),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(26),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete_rounded, color: Color(0xFFFF9999), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Xóa',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF9999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),

        // Edit button
        Expanded(
          flex: 2,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFB6C1).withOpacity(0.4),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(26),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Chỉnh sửa',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
)
```

---

## 4. SETTINGS SCREEN (settings_screen.dart)

### Layout
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ⬅️  Cài Đặt                         ┃  App Bar
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                     ┃
┃  ╔═══════════════════════════════╗ ┃
┃  ║      ┌─────────┐              ║ ┃  Profile Card
┃  ║      │  Avatar │              ║ ┃  Gradient bg
┃  ║      └─────────┘              ║ ┃
┃  ║                               ║ ┃
┃  ║    Người dùng xinh đẹp 💕    ║ ┃
┃  ╚═══════════════════════════════╝ ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  🎨 Giao diện                       ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ 🌙  Chế độ tối          ○   │  ┃  Toggle
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  🔔 Thông báo                       ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ 🔔  Nhận thông báo      ●   │  ┃  Toggle
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ ⏰  Nhắc trước        3 ngày │  ┃  Option
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃  ℹ️ Về ứng dụng                     ┃
┃  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ 📱  Phiên bản        v1.0.0 │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┃  ┌─────────────────────────────┐  ┃
┃  │ ⭐  Đánh giá ứng dụng       │  ┃
┃  └─────────────────────────────┘  ┃
┃                                     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

## 5. RESPONSIVE MEASUREMENTS

### Standard Sizes
- Status bar: 24-44dp (system)
- App bar height: 56dp
- Search bar height: 48dp
- Tab bar height: 64dp (with counts)
- Category chip height: 48dp
- Food card height: 96dp
- Text field height: 56dp
- Button height: 52dp
- FAB size: 56x56dp
- Icon button: 40x40dp

### Spacing
- Screen horizontal padding: 16dp
- Section vertical spacing: 24dp
- Card margin vertical: 8dp
- Card margin horizontal: 16dp
- Card internal padding: 12-16dp
- Element spacing: 8-12dp
- Icon-text gap: 8dp

---

## SUMMARY

This wireframe document provides pixel-perfect specifications for implementing the cute, feminine redesign of Fridge Tracker. Each component includes:

1. Visual layout with ASCII diagrams
2. Detailed measurements
3. Color specifications
4. Flutter code examples
5. Interaction patterns

Developers can use these wireframes alongside DESIGN_SYSTEM.md to implement the new design consistently across all screens.
