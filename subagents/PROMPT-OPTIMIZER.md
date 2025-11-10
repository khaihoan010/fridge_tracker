# Hệ Thống Tự Động Tối Ưu Prompt (Vietnamese → English → Sub-agents)

## 📋 Tổng Quan

Hệ thống này cho phép bạn:
1. **Viết prompt bằng tiếng Việt** (ngôn ngữ mẹ đẻ của bạn)
2. **Tự động dịch và tối ưu** sang tiếng Anh chuyên nghiệp
3. **Định tuyến đến đúng sub-agent** với prompt được tối ưu hóa
4. **Đảm bảo chất lượng cao nhất** từ các sub-agents

---

## 🎯 Tại Sao Cần Hệ Thống Này?

### Vấn Đề
- Các AI models (bao gồm sub-agents) hoạt động **tốt nhất với tiếng Anh**
- Tiếng Việt có thể bị **mất nghĩa** hoặc **hiểu sai** khi dịch trực tiếp
- Technical terms bằng tiếng Việt thường **không chuẩn xác**

### Giải Pháp
- Bạn viết bằng **tiếng Việt thoải mái**
- Hệ thống dịch sang **tiếng Anh technical chuẩn**
- Sub-agents nhận được **prompt chất lượng cao**
- Kết quả **chính xác và hiệu quả hơn**

---

## 🔄 Quy Trình Hoạt Động

```
┌─────────────────────────────────────────────────────────────┐
│  1. BẠN: Viết prompt bằng tiếng Việt                        │
└─────────────────────┬───────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────────┐
│  2. HỆ THỐNG: Phân tích prompt của bạn                      │
│     - Xác định domain (backend, mobile, web, etc.)          │
│     - Trích xuất technical terms                            │
│     - Hiểu context và intent                                │
└─────────────────────┬───────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────────┐
│  3. HỆ THỐNG: Dịch và tối ưu                                │
│     - Dịch sang tiếng Anh technical                         │
│     - Thêm context cần thiết                                │
│     - Format theo chuẩn professional                        │
│     - Thêm technical details                                │
└─────────────────────┬───────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────────┐
│  4. HỆ THỐNG: Định tuyến đến đúng sub-agent                │
│     - Chọn agent phù hợp nhất                               │
│     - Có thể chọn nhiều agents nếu cần                      │
└─────────────────────┬───────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────────┐
│  5. SUB-AGENT: Xử lý với prompt đã tối ưu                   │
│     - Nhận prompt tiếng Anh chuẩn                           │
│     - Hiểu rõ yêu cầu                                       │
│     - Thực thi chính xác                                    │
└─────────────────────┬───────────────────────────────────────┘
                      ↓
┌─────────────────────────────────────────────────────────────┐
│  6. KẾT QUẢ: Trả về cho bạn (tiếng Việt hoặc Anh)          │
└─────────────────────────────────────────────────────────────┘
```

---

## 🧠 Cơ Chế Dịch Thông Minh

### Bước 1: Phân Tích Ngữ Cảnh

```python
# Ví dụ: Phân tích prompt của bạn

INPUT (Tiếng Việt):
"Tôi muốn tạo API để người dùng đăng nhập với email và password.
Dùng JWT token và lưu trong Redis."

PHÂN TÍCH:
- Domain: Backend/API Development
- Technologies: REST API, JWT, Redis
- Task: Authentication system
- Target Agent: backend-architect
- Complexity: Medium
- Required details: Security practices, token expiry, error handling
```

### Bước 2: Ánh Xạ Technical Terms

| Tiếng Việt | Tiếng Anh (Chuẩn) | Context |
|------------|-------------------|---------|
| đăng nhập | authentication / login | Auth context |
| người dùng | user | General |
| mã thông báo | token | JWT/Auth |
| lưu trữ | store / cache | Redis context |
| cơ sở dữ liệu | database | General |
| màn hình | screen (mobile) / page (web) | Platform-specific |
| nút bấm | button | UI context |
| phản hồi | response | API context |
| yêu cầu | request | API context |
| triển khai | deployment | DevOps |
| tối ưu | optimization | Performance |

### Bước 3: Tối Ưu Prompt

```markdown
INPUT (Tiếng Việt - Của bạn):
"Làm API đăng nhập với JWT"

OUTPUT (Tiếng Anh - Tối ưu cho agent):
"I need to implement a secure authentication API with the following requirements:

**Core Functionality:**
- User login endpoint with email/password
- JWT token generation and validation
- Token refresh mechanism

**Technical Requirements:**
- Use Go with Clean Architecture pattern
- Store tokens in Redis with appropriate TTL
- Implement proper error handling
- Follow security best practices (password hashing, rate limiting)

**Expected Deliverables:**
1. API endpoint design and implementation
2. JWT middleware for protected routes
3. Redis integration for token management
4. Unit tests for authentication flow
5. API documentation

**Security Considerations:**
- Bcrypt for password hashing
- Short-lived access tokens (15 minutes)
- Long-lived refresh tokens (7 days)
- Rate limiting on login endpoint
- Input validation and sanitization

Please provide code examples following Go best practices."
```

**Lợi ích của việc tối ưu:**
- ✅ Rõ ràng và cụ thể hơn
- ✅ Bao gồm technical details cần thiết
- ✅ Có cấu trúc và dễ hiểu
- ✅ Đề cập đến best practices
- ✅ Yêu cầu deliverables cụ thể

---

## 📝 Ví Dụ Thực Tế

### Ví Dụ 1: Backend Development

#### Bạn viết (Tiếng Việt):
```
Tôi cần làm hệ thống upload ảnh. Người dùng chọn ảnh, upload lên server,
server resize và lưu vào S3. Trả về URL cho client.
```

#### Hệ thống dịch và tối ưu (Tiếng Anh):
```
@backend-architect

I need to implement an image upload system with the following specifications:

**User Flow:**
1. User selects image from device
2. Client uploads image to backend
3. Server processes and stores image
4. Client receives image URL

**Backend Requirements:**
- Accept multipart/form-data file uploads
- Validate image type (JPEG, PNG, WebP) and size (max 10MB)
- Generate unique filename to prevent collisions
- Resize image to multiple dimensions (thumbnail, medium, large)
- Upload to AWS S3 or compatible object storage
- Return URLs for all image sizes

**Technical Stack:**
- Go backend with Clean Architecture
- Image processing library (e.g., imaging, bimg)
- AWS SDK for S3 integration
- Concurrent processing for multiple sizes

**Expected Deliverables:**
1. Upload endpoint implementation
2. Image validation and processing logic
3. S3 integration with proper error handling
4. Response format with image URLs
5. Unit tests for upload flow

**Performance Considerations:**
- Stream file upload to avoid memory issues
- Process image resizing concurrently
- Implement upload progress tracking
- Set appropriate timeouts

Please provide complete code implementation with error handling.
```

---

### Ví Dụ 2: Flutter Mobile Development

#### Bạn viết (Tiếng Việt):
```
Làm màn hình danh sách sản phẩm. Có search, filter theo giá,
kéo xuống load thêm. Dữ liệu từ API.
```

#### Hệ thống dịch và tối ưu (Tiếng Anh):
```
@flutter-expert

I need to implement a product listing screen with the following features:

**UI Requirements:**
- Grid or list view of products
- Each product shows: image, name, price, rating
- Search bar at the top
- Filter button (by price range)
- Pull-to-refresh functionality
- Infinite scroll / Load more on scroll

**Functionality:**
- Fetch products from REST API
- Search products by name (with debouncing)
- Filter products by price range
- Pagination (load 20 items per page)
- Loading states (initial, refresh, load more)
- Error handling with retry option
- Empty state when no products found

**Technical Requirements:**
- Use Riverpod for state management
- Implement Clean Architecture
- Separate UI, domain, and data layers
- Use dio for HTTP requests
- Cache products locally (optional)
- Smooth animations and transitions

**Expected Deliverables:**
1. ProductListScreen widget
2. ProductListProvider with Riverpod
3. ProductRepository for API calls
4. Search and filter logic
5. Pagination implementation
6. Loading and error states

**Performance Optimization:**
- Lazy loading of images
- Debounce search input (300ms)
- Cache network responses
- Optimize list rendering with ListView.builder

Please provide complete code with proper separation of concerns.
```

---

### Ví Dụ 3: UI/UX Design

#### Bạn viết (Tiếng Việt):
```
Thiết kế màn hình đăng ký. Cần form nhập tên, email, mật khẩu.
Có nút đăng ký và link đăng nhập.
```

#### Hệ thống dịch và tối ưu (Tiếng Anh):
```
@uiux-designer

I need a user registration screen design with modern UX best practices:

**Required Elements:**
- Registration form with fields:
  - Full name (text input)
  - Email (email input with validation)
  - Password (password input with strength indicator)
  - Confirm password
- Primary CTA button: "Sign Up" / "Create Account"
- Link to login: "Already have an account? Sign In"
- Terms and Privacy policy agreement checkbox
- Social login options (optional): Google, Apple

**Design Specifications:**
- Mobile-first responsive design
- Follow Material Design / iOS Human Interface Guidelines
- Accessibility compliance (WCAG 2.1 AA)
- Clear visual hierarchy
- Proper spacing and typography
- Form validation states (error, success, focus)

**UX Requirements:**
- Autofocus on first field
- Show/hide password toggle
- Real-time password strength indicator
- Inline validation (on blur)
- Clear error messages
- Loading state on submit
- Disabled state for submit button until form is valid

**Expected Deliverables:**
1. High-fidelity mockup (mobile and desktop)
2. Design system tokens (colors, spacing, typography)
3. Component specifications
4. Interaction states (default, hover, focus, error, disabled)
5. Accessibility notes
6. Implementation guidelines for developers

**Design Principles:**
- Minimize cognitive load
- Guide user through the process
- Build trust with clear communication
- Reduce friction in signup process

Please provide detailed design with annotations.
```

---

### Ví Dụ 4: DevOps

#### Bạn viết (Tiếng Việt):
```
Cần setup CI/CD cho dự án Go. Khi push code lên GitHub,
tự động chạy test, build Docker image, deploy lên Kubernetes.
```

#### Hệ thống dịch và tối ưu (Tiếng Anh):
```
@devops-engineer

I need to set up a complete CI/CD pipeline for a Go application with the following workflow:

**CI/CD Requirements:**

**Trigger:**
- Activate on push to main branch
- Activate on pull request

**Pipeline Stages:**

1. **Code Quality & Testing**
   - Lint Go code (golangci-lint)
   - Run unit tests
   - Generate code coverage report
   - Fail if coverage < 80%

2. **Build**
   - Build Go binary
   - Create Docker image with multi-stage build
   - Tag image with git commit SHA and latest
   - Scan image for vulnerabilities (Trivy)

3. **Push**
   - Push Docker image to registry (Docker Hub / ECR / GCR)

4. **Deploy**
   - Deploy to Kubernetes cluster
   - Update deployment with new image tag
   - Perform rolling update (zero downtime)
   - Health check after deployment
   - Rollback on failure

**Technical Stack:**
- GitHub Actions (preferred) or GitLab CI
- Docker multi-stage builds
- Kubernetes (EKS, GKE, or self-hosted)
- Helm charts (optional but recommended)

**Security Requirements:**
- Store secrets in GitHub Secrets or HashiCorp Vault
- Scan Docker images for vulnerabilities
- Use least-privilege service accounts
- Implement image signing (optional)

**Expected Deliverables:**
1. CI/CD configuration file (.github/workflows/ci-cd.yml)
2. Dockerfile with multi-stage build
3. Kubernetes deployment manifests
4. Helm chart (if applicable)
5. Documentation for setup and usage

**Additional Requirements:**
- Notifications on pipeline failure (Slack, email)
- Deployment only on main branch
- Manual approval for production deployments
- Environment-specific configurations (dev, staging, prod)

Please provide complete working pipeline configuration.
```

---

## 🎨 Từ Điển Technical Terms (Vietnamese → English)

### Backend & APIs

| Tiếng Việt | English | Notes |
|------------|---------|-------|
| API | API / REST API | Giữ nguyên |
| điểm cuối / endpoint | endpoint | |
| yêu cầu | request | HTTP context |
| phản hồi | response | HTTP context |
| dữ liệu | data | |
| cơ sở dữ liệu | database | |
| bảng | table | Database |
| truy vấn | query | Database |
| lưu trữ | store / persist | |
| xác thực | authentication | Security |
| phân quyền | authorization | Security |
| mã hóa | encryption | Security |
| băm mật khẩu | password hashing | |
| token | token | Giữ nguyên |
| phiên làm việc | session | |
| bộ nhớ đệm | cache | |
| hàng đợi | queue | |
| worker | worker | Giữ nguyên |
| middleware | middleware | Giữ nguyên |
| xử lý lỗi | error handling | |
| ghi log | logging | |
| giám sát | monitoring | |

### Mobile Development

| Tiếng Việt | English | Notes |
|------------|---------|-------|
| màn hình | screen | Mobile context |
| trang | page | Web context |
| điều hướng | navigation | |
| widget | widget | Flutter |
| component | component | React Native |
| trạng thái | state | State management |
| thuộc tính | props / properties | |
| sự kiện | event | |
| cử chỉ | gesture | Touch interactions |
| vuốt | swipe | |
| chạm | tap | |
| cuộn | scroll | |
| animation | animation | Giữ nguyên |
| hiệu ứng | effect / animation | |
| theme | theme | Giữ nguyên |
| màu sắc | color | |
| phông chữ | font / typography | |
| layout | layout | Giữ nguyên |

### Web Development

| Tiếng Việt | English | Notes |
|------------|---------|-------|
| trang web | web page | |
| component | component | React/Vue |
| hook | hook | React |
| route | route | Navigation |
| render | render | Giữ nguyên |
| SSR | Server-Side Rendering | |
| SSG | Static Site Generation | |
| SEO | SEO | Giữ nguyên |
| responsive | responsive | Giữ nguyên |
| breakpoint | breakpoint | CSS |

### DevOps

| Tiếng Việt | English | Notes |
|------------|---------|-------|
| triển khai | deployment | |
| CI/CD | CI/CD | Giữ nguyên |
| container | container | Docker |
| image | image | Docker |
| cluster | cluster | Kubernetes |
| pod | pod | Kubernetes |
| service | service | Kubernetes |
| ingress | ingress | Kubernetes |
| pipeline | pipeline | CI/CD |
| artifact | artifact | Build output |
| registry | registry | Docker |
| hạ tầng | infrastructure | |
| mở rộng | scaling | |
| load balancer | load balancer | Giữ nguyên |
| giám sát | monitoring | |
| cảnh báo | alert | |

---

## 🚀 Cách Sử Dụng Hệ Thống

### Phương Pháp 1: Tự Động (Khuyến Nghị)

Chỉ cần viết prompt bằng tiếng Việt tự nhiên, hệ thống sẽ tự động:

```
Bạn: Tôi cần làm API đăng nhập cho ứng dụng Flutter. Dùng Go backend,
     JWT token, và lưu trong Redis. Cần có refresh token nữa.

[HỆ THỐNG TỰ ĐỘNG:]
1. Phát hiện: Backend + Mobile task
2. Dịch và tối ưu prompt
3. Định tuyến: @backend-architect + @flutter-expert
4. Trả kết quả chất lượng cao
```

### Phương Pháp 2: Chỉ Định Agent

Nếu bạn biết rõ cần agent nào, chỉ định trực tiếp:

```
@backend-architect

Tôi cần API upload file với các yêu cầu:
- Hỗ trợ nhiều file cùng lúc
- Giới hạn 10MB mỗi file
- Lưu vào S3
- Trả về URL sau khi upload thành công

[HỆ THỐNG:]
1. Nhận diện: Đã chỉ định @backend-architect
2. Dịch và tối ưu prompt cho backend context
3. Gửi đến backend-architect
4. Trả kết quả
```

### Phương Pháp 3: Multi-Agent

Cho các task phức tạp cần nhiều agents:

```
Bạn: Tôi cần làm tính năng chat real-time cho ứng dụng.
     Bao gồm:
     - Backend API với WebSocket
     - Màn hình chat trong Flutter app
     - Lưu tin nhắn vào database
     - Push notification khi có tin nhắn mới

[HỆ THỐNG TỰ ĐỘNG:]
1. Phát hiện: Cần 2-3 agents
2. Tạo prompts riêng cho mỗi agent:

   @backend-architect
   "Implement real-time chat system with:
   - WebSocket server for real-time messaging
   - REST API for message history
   - PostgreSQL for message persistence
   - Redis for online status tracking
   - Push notification service integration"

   @flutter-expert
   "Build chat screen with:
   - WebSocket client for real-time updates
   - Message list with infinite scroll
   - Message input with file attachment
   - Online status indicators
   - Push notification handling"

3. Phối hợp kết quả từ cả hai agents
4. Đảm bảo backend và frontend tương thích
```

---

## 📊 Quy Tắc Dịch & Tối Ưu

### 1. Giữ Nguyên Technical Terms

```
❌ Không nên:
"công cụ phản ứng" → React
"nút băm địa chỉ phân tán" → Redis

✅ Nên:
"React" → React
"Redis" → Redis
"JWT" → JWT
```

### 2. Thêm Context Khi Cần

```
Tiếng Việt (Mơ hồ):
"Làm màn hình login"

Tiếng Anh (Rõ ràng):
"Create a login screen for mobile app (Flutter) with:
- Email and password input fields
- Form validation
- Loading state
- Error handling
- Remember me checkbox
- Forgot password link"
```

### 3. Làm Rõ Technical Requirements

```
Tiếng Việt (Chung chung):
"Làm API nhanh"

Tiếng Anh (Cụ thể):
"Build a high-performance API with:
- Response time < 100ms
- Support 1000 concurrent requests
- Database query optimization
- Redis caching strategy
- Connection pooling
- Proper indexing"
```

### 4. Thêm Best Practices

```
Tiếng Việt (Cơ bản):
"Làm hệ thống đăng nhập"

Tiếng Anh (Professional):
"Implement authentication system following security best practices:
- Password hashing with bcrypt
- JWT tokens with short expiry
- Refresh token mechanism
- Rate limiting on login endpoint
- Account lockout after failed attempts
- Secure password reset flow
- Email verification
- Audit logging"
```

---

## 🎯 Tips Để Có Kết Quả Tốt Nhất

### 1. Cung Cấp Đủ Context

```
✅ Tốt:
"Tôi đang làm ứng dụng e-commerce bán quần áo. Cần màn hình
danh sách sản phẩm với filter theo size, màu sắc, giá.
Người dùng có thể thêm vào giỏ hàng trực tiếp từ danh sách."

❌ Không đủ:
"Làm trang sản phẩm"
```

### 2. Nói Rõ Tech Stack (Nếu Có)

```
✅ Tốt:
"Backend Go với PostgreSQL, frontend Next.js 14, deploy trên AWS"

❌ Không rõ:
"Dùng các công nghệ hiện đại"
```

### 3. Đề Cập Constraints

```
✅ Tốt:
"Budget $500/tháng cho AWS, cần support 10,000 users,
response time dưới 200ms"

❌ Không rõ:
"Làm nhanh và rẻ"
```

### 4. Mô Tả User Flow

```
✅ Tốt:
"User mở app → thấy danh sách sản phẩm → click vào sản phẩm
→ xem chi tiết → thêm vào giỏ → thanh toán"

❌ Không rõ:
"Làm app bán hàng"
```

---

## 🧪 Testing & Validation

### Kiểm Tra Quality của Prompt Đã Tối Ưu

Prompt tốt cần có:

- [ ] **Clarity**: Rõ ràng, không mơ hồ
- [ ] **Completeness**: Đầy đủ thông tin
- [ ] **Context**: Có bối cảnh cụ thể
- [ ] **Constraints**: Nêu rõ giới hạn
- [ ] **Expected Output**: Mô tả kết quả mong muốn
- [ ] **Technical Details**: Có yêu cầu kỹ thuật
- [ ] **Best Practices**: Đề cập đến chuẩn mực

### Ví Dụ Kiểm Tra

```markdown
## INPUT (Tiếng Việt)
"Làm API upload ảnh"

## OUTPUT (Tiếng Anh - Tối ưu)

Quality Check:
✅ Clarity: Rõ ràng về upload flow
✅ Completeness: Có validation, processing, storage
✅ Context: Web/mobile app context
✅ Constraints: File size, image types
✅ Expected Output: API endpoint, S3 URLs
✅ Technical Details: Go, S3, image processing
✅ Best Practices: Security, error handling, testing

Kết luận: Prompt đạt chuẩn ✅
```

---

## 💡 Mẹo Nâng Cao

### 1. Sử Dụng Ví Dụ Cụ Thể

```
Thay vì:
"Làm form validation"

Nên:
"Làm form validation như Airbnb: real-time validation khi user
nhập, hiện icon check màu xanh khi đúng, hiện lỗi màu đỏ bên
dưới field khi sai, disable nút submit khi form chưa hợp lệ"
```

### 2. Reference Best Practices

```
"Làm authentication flow theo chuẩn OWASP, giống như Auth0"
"Implement state management theo Redux pattern như Facebook đang dùng"
"Setup CI/CD pipeline theo GitLab flow"
```

### 3. Đề Cập Edge Cases

```
"Xử lý các trường hợp:
- User upload file quá lớn
- Network bị disconnect giữa chừng
- Server trả về lỗi 500
- Token expired trong khi đang upload"
```

---

## 🎓 Kết Luận

Hệ thống tự động này giúp bạn:

1. ✅ **Viết thoải mái bằng tiếng Việt** - ngôn ngữ mẹ đẻ
2. ✅ **Tự động dịch chính xác** - sang tiếng Anh technical
3. ✅ **Tối ưu prompt** - thêm context và best practices
4. ✅ **Định tuyến thông minh** - đến đúng sub-agent
5. ✅ **Kết quả chất lượng cao** - từ các agents chuyên môn

**Bạn không cần lo lắng về:**
- ❌ Dịch technical terms
- ❌ Viết prompt tiếng Anh
- ❌ Biết agent nào để dùng
- ❌ Format prompt đúng cách

**Hệ thống sẽ tự động làm tất cả cho bạn!**

---

## 🚀 Bắt Đầu Ngay

Chỉ cần viết prompt bằng tiếng Việt như bình thường:

```
"Tôi cần làm [tính năng] với [công nghệ].
Yêu cầu [requirement 1], [requirement 2]..."
```

Hệ thống sẽ:
1. Hiểu ý bạn
2. Dịch và tối ưu
3. Gửi đến đúng agent
4. Trả kết quả chất lượng cao

**Đơn giản vậy thôi! Hãy thử ngay!** 🎉
