# Hướng Dẫn Sử Dụng Sub-Agents

## 📚 Tổng Quan

Bạn có 9 chuyên gia AI hỗ trợ phát triển ứng dụng hoàn chỉnh từ ý tưởng đến ra mắt sản phẩm. Mỗi agent chuyên về một lĩnh vực cụ thể và tuân theo các tiêu chuẩn của các công ty công nghệ hàng đầu.

---

## 🎯 Bảng Tra Cứu Nhanh

| Công Việc Của Bạn | Dùng Agent Này | Ví Dụ Lệnh |
|-------------------|----------------|-------------|
| Định nghĩa tính năng, yêu cầu sản phẩm | Product Manager | "Tạo tài liệu yêu cầu sản phẩm cho app quản lý công việc" |
| Thiết kế UI/UX, wireframe | UI/UX Designer | "Thiết kế màn hình đăng nhập theo chuẩn UX tốt nhất" |
| Xây dựng API backend (Go) | Backend Architect | "Tạo REST API cho hệ thống xác thực người dùng" |
| Phát triển app di động (Flutter) | Flutter Expert | "Xây dựng màn hình chat với tin nhắn real-time" |
| Phát triển app di động (React Native) | React Native Expert | "Tích hợp push notification trong React Native" |
| Xây dựng ứng dụng web | Web Frontend Expert | "Tạo dashboard với Next.js và SSR" |
| Marketing sản phẩm, thu hút người dùng | Marketing & Growth | "Lập kế hoạch ra mắt sản phẩm SaaS của tôi" |
| Cải thiện thứ hạng tìm kiếm | SEO Specialist | "Tối ưu SEO cho landing page của tôi" |
| Triển khai và hạ tầng | DevOps Engineer | "Thiết lập CI/CD pipeline cho ứng dụng Go" |

---

## 🔄 Quy Trình Phát Triển Chuẩn

### Giai Đoạn 1: Lập Kế Hoạch & Thiết Kế (Tuần 1-2)

#### Bước 1: Chiến Lược Sản Phẩm
**Agent:** `product-manager`
```
"Tôi muốn xây dựng [ý tưởng app của bạn]. Hãy giúp tôi:
1. Xác định vấn đề và người dùng mục tiêu
2. Tạo user personas
3. Viết tài liệu yêu cầu sản phẩm (PRD) với các tính năng được ưu tiên theo RICE score
4. Định nghĩa phạm vi MVP"
```

**Kết Quả:** Tài liệu PRD, user stories, chỉ số thành công

#### Bước 2: Nghiên Cứu & Thiết Kế UX
**Agent:** `uiux-designer`
```
"Dựa trên tài liệu PRD, hãy giúp tôi:
1. Tạo user journey maps
2. Thiết kế wireframes cho các màn hình chính
3. Tạo design system (màu sắc, typography, khoảng cách)
4. Thiết kế mockups chi tiết cho [các màn hình cụ thể]"
```

**Kết Quả:** Tài liệu thiết kế, thư viện component, mockups

---

### Giai Đoạn 2: Phát Triển Backend (Tuần 3-4)

**Agent:** `backend-architect`
```
"Tôi cần xây dựng backend cho [tên app]. Hãy giúp tôi:
1. Thiết kế kiến trúc hệ thống
2. Định nghĩa database schema cho [các entities]
3. Tạo REST APIs cho [các tính năng]
4. Triển khai xác thực với JWT
5. Thiết lập caching với Redis"
```

**Ví Dụ Công Việc:**
- ✅ Thiết kế và triển khai API
- ✅ Mô hình hóa database (PostgreSQL)
- ✅ Xác thực & phân quyền
- ✅ Chiến lược caching
- ✅ Xử lý lỗi
- ✅ Chiến lược testing

**Kết Quả:** Tài liệu API, database schemas, code Go

---

### Giai Đoạn 3: Phát Triển Mobile (Tuần 5-6)

#### Lựa Chọn A: Flutter
**Agent:** `flutter-expert`
```
"Xây dựng ứng dụng Flutter với:
1. Các màn hình xác thực (đăng nhập, đăng ký)
2. Quản lý state với Riverpod
3. Tích hợp API với backend của tôi
4. Kiến trúc offline-first
5. Push notifications"
```

#### Lựa Chọn B: React Native
**Agent:** `react-native-expert`
```
"Tạo ứng dụng React Native với:
1. Navigation sử dụng React Navigation
2. Quản lý state với Zustand
3. Gọi API với Axios
4. Native modules cho [tính năng]
5. Deep linking"
```

**Kết Quả:** Code ứng dụng mobile, các màn hình, luồng navigation

---

### Giai Đoạn 4: Phát Triển Web (Tuần 5-6)

**Agent:** `web-frontend-expert`
```
"Xây dựng ứng dụng web Next.js 14 với:
1. Cấu trúc App Router
2. Server Components cho [các trang]
3. API routes cho [các endpoints]
4. Xác thực với NextAuth
5. Responsive design với Tailwind CSS
6. Tối ưu SEO"
```

**Kết Quả:** Ứng dụng web, landing pages, dashboard

---

### Giai Đoạn 5: Hạ Tầng & Triển Khai (Tuần 7)

**Agent:** `devops-engineer`
```
"Thiết lập hạ tầng production:
1. Thiết kế kiến trúc AWS/GCP
2. Tạo cấu hình Terraform
3. Thiết lập Kubernetes cluster
4. Xây dựng CI/CD pipeline (GitHub Actions)
5. Cấu hình monitoring với Prometheus/Grafana
6. Triển khai auto-scaling"
```

**Kết Quả:** Infrastructure as Code, CI/CD pipelines, monitoring dashboards

---

### Giai Đoạn 6: Marketing & Ra Mắt (Tuần 8+)

#### Chiến Lược Marketing
**Agent:** `marketing-growth`
```
"Tạo chiến lược go-to-market:
1. Xác định các kênh thu hút khách hàng
2. Tạo kế hoạch content marketing
3. Thiết lập email campaigns
4. Thiết kế chiến lược social media
5. Lập kế hoạch quảng cáo trả phí (Google Ads, Meta Ads)
6. Tạo analytics dashboard"
```

#### Tối Ưu SEO
**Agent:** `seo-specialist`
```
"Tối ưu website của tôi cho công cụ tìm kiếm:
1. Nghiên cứu từ khóa cho [ngành]
2. Tối ưu on-page SEO (titles, meta, headers)
3. Sửa các vấn đề technical SEO
4. Tạo chiến lược nội dung cho SEO
5. Xây dựng chiến lược backlinks"
```

**Kết Quả:** Kế hoạch marketing, báo cáo SEO audit, lịch xuất bản nội dung

---

## 💼 Các Trường Hợp Sử Dụng Phổ Biến

### Trường Hợp 1: Xây Dựng Sản Phẩm SaaS

**Quy trình sử dụng agents theo từng bước:**

1. **Product Manager** → Định nghĩa tính năng MVP, user stories
2. **UI/UX Designer** → Thiết kế user flows, mockups
3. **Backend Architect** → Xây dựng APIs, database
4. **Web Frontend Expert** → Xây dựng web dashboard
5. **DevOps Engineer** → Triển khai lên production
6. **Marketing & Growth** → Thu hút người dùng
7. **SEO Specialist** → Tăng traffic tự nhiên

### Trường Hợp 2: Xây Dựng Ứng Dụng Mobile

**Quy trình sử dụng agents theo từng bước:**

1. **Product Manager** → Tạo PRD, định nghĩa tính năng
2. **UI/UX Designer** → Thiết kế các màn hình app
3. **Backend Architect** → Xây dựng API backend
4. **Flutter Expert** HOẶC **React Native Expert** → Xây dựng ứng dụng mobile
5. **DevOps Engineer** → Thiết lập CI/CD, triển khai backend
6. **Marketing & Growth** → App Store Optimization, thu hút người dùng
7. **SEO Specialist** → Tối ưu landing page

### Trường Hợp 3: Thêm Tính Năng Mới

**Quy trình nhanh:**

1. **Product Manager** → Viết tài liệu đặc tả tính năng
2. **UI/UX Designer** → Thiết kế màn hình/components mới
3. **Backend Architect** → Thêm API endpoints (nếu cần)
4. **Flutter/RN/Web Expert** → Triển khai frontend
5. **DevOps Engineer** → Triển khai các cập nhật

### Trường Hợp 4: Debug & Tối Ưu

| Vấn Đề | Agent | Prompt |
|--------|-------|--------|
| API phản hồi chậm | Backend Architect | "API của tôi chậm. Hãy giúp tôi tối ưu database queries và thêm caching" |
| Hiệu suất mobile kém | Flutter/RN Expert | "App của tôi bị lag. Hãy giúp tôi tối ưu performance" |
| Tỷ lệ chuyển đổi thấp | UI/UX Designer | "Người dùng không đăng ký. Hãy phân tích luồng onboarding của tôi" |
| Không có traffic tự nhiên | SEO Specialist | "Website của tôi không có traffic. Thực hiện SEO audit và sửa các vấn đề" |
| Chi phí hạ tầng cao | DevOps Engineer | "Giảm chi phí AWS của tôi mà vẫn duy trì hiệu suất" |

---

## 🎓 Cách Viết Prompt Hiệu Quả

### ❌ Prompt Không Tốt
```
"Xây dựng một ứng dụng"
```

### ✅ Prompt Tốt
```
"Tôi đang xây dựng ứng dụng quản lý công việc cho các team nhỏ.

Bối cảnh:
- Người dùng mục tiêu: Doanh nghiệp nhỏ (5-20 người)
- Tính năng chính: Tasks, projects, team collaboration
- Nền tảng: Web (chính), Mobile (phụ)

Hãy giúp tôi:
1. Thiết kế kiến trúc hệ thống
2. Tạo database schema cho users, projects, và tasks
3. Xây dựng REST APIs cho các thao tác CRUD
4. Triển khai cập nhật real-time với WebSockets

Tech stack: Go backend, PostgreSQL, Redis, Next.js frontend"
```

### Mẫu Prompt Chuẩn

```markdown
Tôi đang xây dựng [tên app] cho [người dùng mục tiêu].

Bối cảnh:
- Mục đích: [giải quyết vấn đề gì]
- Đối tượng: [ai sử dụng]
- Tính năng chính: [các tính năng chính]
- Nền tảng: [web/mobile/cả hai]
- Giai đoạn hiện tại: [ý tưởng/MVP/tăng trưởng]

Hãy giúp tôi:
1. [Công việc cụ thể 1]
2. [Công việc cụ thể 2]
3. [Công việc cụ thể 3]

Tech stack: [nếu đã quyết định]
Giới hạn: [ngân sách, thời gian, v.v.]
```

---

## 🔀 Mô Hình Phối Hợp Agents

### Mô Hình 1: Tuần Tự (Lần lượt)
```
Product Manager → UI/UX Designer → Backend Architect → Flutter Expert
```
Sử dụng khi: Mỗi bước phụ thuộc vào công việc trước đó

### Mô Hình 2: Song Song (Cùng lúc)
```
Backend Architect + Flutter Expert + Web Frontend Expert
                    ↓
              DevOps Engineer
```
Sử dụng khi: Các team làm việc độc lập trên các phần khác nhau

### Mô Hình 3: Lặp lại (Vòng lặp)
```
Product Manager → Designer → Developer → User Testing → Product Manager
```
Sử dụng khi: Cần cải tiến dựa trên phản hồi

---

## 📊 Cây Quyết Định: Dùng Agent Nào?

```
Bắt đầu: Bạn cần giúp đỡ về việc gì?
│
├─ 📋 Định nghĩa CÁI GÌ cần xây dựng?
│  └─ Dùng: Product Manager
│
├─ 🎨 Thiết kế NHƯ THẾ NÀO nó trông?
│  └─ Dùng: UI/UX Designer
│
├─ ⚙️ Xây dựng BACKEND?
│  └─ Dùng: Backend Architect
│
├─ 📱 Xây dựng ỨNG DỤNG MOBILE?
│  ├─ Đa nền tảng (iOS + Android) → Dùng: Flutter Expert
│  └─ Cần native modules → Dùng: React Native Expert
│
├─ 🌐 Xây dựng WEBSITE?
│  └─ Dùng: Web Frontend Expert
│
├─ 🚀 TRIỂN KHAI lên production?
│  └─ Dùng: DevOps Engineer
│
├─ 📈 Thu hút THÊM NGƯỜI DÙNG?
│  └─ Dùng: Marketing & Growth
│
└─ 🔍 Cải thiện THỨ HẠNG TÌM KIẾM?
   └─ Dùng: SEO Specialist
```

---

## 💡 Mẹo Chuyên Nghiệp

### 1. Bắt Đầu Với Product Manager
Luôn bắt đầu với lập kế hoạch sản phẩm trước khi nhảy vào code:
```
❌ Không nên: "Xây cho tôi app chat" → Bắt đầu code ngay
✅ Nên: Product Manager → Định nghĩa yêu cầu → Sau đó code
```

### 2. Thiết Kế Trước Khi Phát Triển
Hoàn thiện UI/UX trước khi xây dựng:
```
❌ Không nên: Xây dựng tính năng → Sau đó thiết kế UI
✅ Nên: Thiết kế mockups → Được duyệt → Sau đó triển khai
```

### 3. Sử Dụng Nhiều Agents Trong Cùng Phiên
Bạn có thể chuyển đổi giữa các agents trong một cuộc trò chuyện:
```
"@product-manager: Tạo user stories cho hệ thống xác thực

@uiux-designer: Thiết kế màn hình đăng nhập dựa trên user stories đó

@backend-architect: Xây dựng authentication API"
```

### 4. Tham Chiếu Công Việc Trước Đó
Agents có thể xây dựng dựa trên công việc của nhau:
```
"Dựa trên thiết kế API từ Backend Architect,
hãy giúp tôi tích hợp nó vào ứng dụng Flutter của tôi"
```

### 5. Hỏi Về Best Practices
Mỗi agent biết các chuẩn ngành:
```
"Best practices về bảo mật cho API authentication là gì?"
"Cách đúng đắn để cấu trúc dự án Flutter?"
"CI/CD pipeline được khuyến nghị cho ứng dụng Go là gì?"
```

---

## 🎯 Các Kịch Bản Khởi Động Nhanh

### Kịch Bản 1: "Tôi có một ý tưởng app"
```
1. Nói chuyện với Product Manager - Tạo PRD
2. Nói chuyện với UI/UX Designer - Thiết kế mockups
3. Nhận ước tính từ các technical agents
4. Lập kế hoạch timeline
```

### Kịch Bản 2: "Tôi sẵn sàng xây dựng"
```
1. Backend Architect - Thiết lập backend
2. Flutter/RN/Web Expert - Xây dựng frontend
3. Kết nối frontend với backend
4. Test tích hợp
```

### Kịch Bản 3: "Tôi cần ra mắt"
```
1. DevOps Engineer - Triển khai lên production
2. Marketing & Growth - Tạo kế hoạch ra mắt
3. SEO Specialist - Tối ưu cho tìm kiếm
4. Theo dõi chỉ số
```

### Kịch Bản 4: "Tôi cần thêm người dùng"
```
1. Marketing & Growth - Phân tích funnel, tạo campaigns
2. SEO Specialist - Cải thiện organic traffic
3. UI/UX Designer - Tối ưu conversion
4. Product Manager - Thêm tính năng viral
```

---

## 📝 Ví Dụ Luồng Hội Thoại

```markdown
Bạn: Tôi muốn xây dựng ứng dụng theo dõi sức khỏe

Product Manager: Để tôi giúp bạn định nghĩa MVP...
[Tạo PRD với user stories, các tính năng được ưu tiên]

Bạn: Tuyệt! Giờ tôi cần thiết kế

UI/UX Designer: Dựa trên PRD, đây là các màn hình chính...
[Cung cấp wireframes, design system, mockups]

Bạn: Hoàn hảo. Hãy xây dựng backend

Backend Architect: Tôi sẽ thiết kế kiến trúc hệ thống...
[Cung cấp database schema, thiết kế API, code Go]

Bạn: Giờ là ứng dụng mobile

Flutter Expert: Tôi sẽ tạo ứng dụng Flutter với...
[Cung cấp cấu trúc dự án Flutter, quản lý state, các màn hình]

Bạn: Làm sao để triển khai?

DevOps Engineer: Đây là chiến lược triển khai...
[Cung cấp cấu hình Terraform, CI/CD pipeline, K8s configs]

Bạn: Làm sao để có người dùng?

Marketing & Growth: Đây là chiến lược go-to-market của bạn...
[Cung cấp kế hoạch marketing, ad campaigns, chiến lược ASO]

Bạn: Làm sao để xếp hạng trên Google?

SEO Specialist: Để tôi audit website và...
[Cung cấp báo cáo SEO audit, chiến lược từ khóa, kế hoạch tối ưu]
```

---

## 🔧 Xử Lý Sự Cố

### "Tôi không biết nên dùng agent nào"
→ Hỏi Product Manager để giúp bạn phân tích vấn đề trước

### "Agent không hiểu yêu cầu của tôi"
→ Cung cấp thêm bối cảnh: người dùng mục tiêu, tech stack, yêu cầu cụ thể

### "Tôi cần giúp đỡ từ nhiều agents"
→ Bắt đầu cuộc trò chuyện, sau đó tham chiếu các agents khi cần

### "Code không hoạt động"
→ Quay lại agent cụ thể với thông báo lỗi và bối cảnh

### "Tôi cần sửa code hiện có"
→ Cho agent xem code hiện tại và giải thích bạn muốn thay đổi gì

---

## 📚 Tài Nguyên Học Tập

Mỗi file agent chứa:
- ✅ Best practices từ các công ty hàng đầu
- ✅ Ví dụ code và templates
- ✅ Checklists và hướng dẫn
- ✅ Các patterns thông dụng và anti-patterns
- ✅ Khuyến nghị công cụ

Đọc các file agents để hiểu sâu hơn!

---

## 🎓 Sử Dụng Nâng Cao

### Dự Án Multi-Agent
Đối với dự án phức tạp, phối hợp nhiều agents:

```markdown
## Tuần 1-2: Giai Đoạn Lập Kế Hoạch
@product-manager: Tạo PRD đầy đủ
@uiux-designer: Thiết kế toàn bộ user flows

## Tuần 3-4: Giai Đoạn Phát Triển
@backend-architect: Xây dựng hạ tầng API
@web-frontend-expert: Xây dựng website marketing
@flutter-expert: Bắt đầu ứng dụng mobile

## Tuần 5: Hạ Tầng
@devops-engineer: Thiết lập môi trường production

## Tuần 6-8: Ra Mắt
@marketing-growth: Thực hiện kế hoạch ra mắt
@seo-specialist: Tối ưu cho công cụ tìm kiếm
```

### Cải Tiến Liên Tục
Sử dụng agents trong chu trình liên tục:

```
Ra mắt → Theo dõi → Phân tích → Cải thiện → Lặp lại
           ↓         ↓         ↓
      DevOps    Analytics   Product Manager
                             UI/UX Designer
                             Developers
```

---

## 🎯 Chỉ Số Thành Công

Theo dõi các chỉ số này với sự giúp đỡ của mỗi agent:

| Agent | Chỉ Số Cần Theo Dõi |
|-------|---------------------|
| Product Manager | Feature adoption, user satisfaction, NPS |
| UI/UX Designer | Task completion rate, time on task, bounce rate |
| Backend Architect | API latency, error rate, uptime |
| Mobile Developers | App store rating, crash rate, session length |
| Web Frontend | Core Web Vitals, conversion rate, page load time |
| DevOps | Deployment frequency, MTTR, infrastructure costs |
| Marketing & Growth | CAC, LTV, conversion rate, MRR |
| SEO Specialist | Organic traffic, keyword rankings, backlinks |

---

## 🚀 Sẵn Sàng Bắt Đầu?

1. **Chọn điểm khởi đầu** từ Cây Quyết Định ở trên
2. **Viết prompt rõ ràng** sử dụng mẫu
3. **Làm theo hướng dẫn của agent** và đặt câu hỏi
4. **Lặp lại và cải thiện** dựa trên kết quả
5. **Chuyển sang agent tiếp theo** khi sẵn sàng

Nhớ rằng: Các agents này ở đây để giúp bạn xây dựng sản phẩm tuyệt vời. Đừng ngần ngại đặt câu hỏi, yêu cầu làm rõ, hoặc đi sâu vào bất kỳ chủ đề nào!

---

## 📞 Tham Chiếu Lệnh Nhanh

```bash
# Bắt đầu phiên lập kế hoạch
@product-manager "Giúp tôi lập kế hoạch cho [ý tưởng app]"

# Nhận giúp đỡ về thiết kế
@uiux-designer "Thiết kế [màn hình/luồng cụ thể]"

# Phát triển backend
@backend-architect "Xây dựng API cho [tính năng]"

# Phát triển mobile
@flutter-expert "Triển khai [tính năng] trong Flutter"
@react-native-expert "Tạo [màn hình] trong React Native"

# Phát triển web
@web-frontend-expert "Xây dựng [trang] với Next.js"

# Triển khai và mở rộng
@devops-engineer "Thiết lập [hạ tầng/pipeline]"

# Phát triển sản phẩm
@marketing-growth "Tạo chiến lược cho [mục tiêu]"
@seo-specialist "Tối ưu [trang/site] cho SEO"
```

---

## 🌟 Lưu Ý Quan Trọng

### Về Ngôn Ngữ
- Bạn có thể viết prompt bằng **tiếng Việt** hoặc **tiếng Anh**
- Các agents sẽ hiểu và phản hồi phù hợp với ngôn ngữ bạn sử dụng
- Để có kết quả tốt nhất, hãy viết prompt chi tiết và rõ ràng

### Về Chất Lượng Kết Quả
- Agents được huấn luyện theo chuẩn của **Google, Meta, Netflix, Airbnb, Stripe**
- Code và architecture tuân theo **best practices** mới nhất
- Tất cả recommendations đều đã được **production-tested**

### Về Bảo Mật
- Không chia sẻ credentials, API keys trong prompts
- Review code về security trước khi deploy
- Sử dụng environment variables cho sensitive data

---

## 📖 Đọc Thêm

- [README.md](./README.md) - English version
- [product-manager.md](./product-manager.md) - Chi tiết về Product Management
- [backend-architect.md](./backend-architect.md) - Go Backend Development Guide
- [flutter-expert.md](./flutter-expert.md) - Flutter Development Guide
- [devops-engineer.md](./devops-engineer.md) - DevOps & Infrastructure Guide

---

Chúc bạn thành công trong việc xây dựng sản phẩm! 🚀

**Nếu có câu hỏi, chỉ cần hỏi trực tiếp agent tương ứng!**
