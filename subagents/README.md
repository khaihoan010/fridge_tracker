# Sub-Agents Usage Guide

## 📚 Overview

This guide helps you understand when and how to use each sub-agent for your full-stack development workflow. Each agent is specialized in specific domains and follows best practices from top tech companies.

---

## 🎯 Quick Reference Matrix

| Your Task | Use This Agent | Example Prompt |
|-----------|---------------|----------------|
| Define product features, requirements | Product Manager | "Create a PRD for a project management app" |
| Design UI/UX, wireframes | UI/UX Designer | "Design a login screen with best UX practices" |
| Build backend APIs (Go) | Backend Architect | "Create a REST API for user authentication" |
| Develop mobile app (Flutter) | Flutter Expert | "Build a chat screen with real-time messaging" |
| Develop mobile app (React Native) | React Native Expert | "Implement push notifications in React Native" |
| Build web application | Web Frontend Expert | "Create a Next.js dashboard with SSR" |
| Market the product, get users | Marketing & Growth | "Create a launch plan for my SaaS product" |
| Improve search rankings | SEO Specialist | "Optimize my landing page for SEO" |
| Deploy and infrastructure | DevOps Engineer | "Set up CI/CD pipeline for my Go app" |

---

## 🔄 Development Workflow

### Phase 1: Planning & Design (Week 1-2)

#### Step 1: Product Strategy
**Agent:** `product-manager.md`
```
"I want to build [your app idea]. Help me:
1. Define the problem and target users
2. Create user personas
3. Write a PRD with features prioritized by RICE score
4. Define MVP scope"
```

**Output:** PRD document, user stories, success metrics

#### Step 2: UX Research & Design
**Agent:** `uiux-designer.md`
```
"Based on the PRD, help me:
1. Create user journey maps
2. Design wireframes for key screens
3. Create a design system (colors, typography, spacing)
4. Design high-fidelity mockups for [specific screens]"
```

**Output:** Design specifications, component library, mockups

---

### Phase 2: Backend Development (Week 3-4)

**Agent:** `backend-architect.md`
```
"I need to build a backend for [app name]. Help me:
1. Design the system architecture
2. Define database schema for [entities]
3. Create REST APIs for [features]
4. Implement authentication with JWT
5. Set up caching with Redis"
```

**Example Tasks:**
- ✅ API design and implementation
- ✅ Database modeling (PostgreSQL)
- ✅ Authentication & authorization
- ✅ Caching strategies
- ✅ Error handling
- ✅ Testing strategies

**Deliverables:** API documentation, database schemas, Go code

---

### Phase 3: Mobile Development (Week 5-6)

#### Option A: Flutter
**Agent:** `flutter-expert.md`
```
"Build a Flutter app with:
1. Authentication screens (login, register)
2. State management with Riverpod
3. API integration with my backend
4. Offline-first architecture
5. Push notifications"
```

#### Option B: React Native
**Agent:** `react-native-expert.md`
```
"Create a React Native app with:
1. Navigation using React Navigation
2. State management with Zustand
3. API calls with Axios
4. Native modules for [feature]
5. Deep linking"
```

**Deliverables:** Mobile app code, screens, navigation flow

---

### Phase 4: Web Development (Week 5-6)

**Agent:** `web-frontend-expert.md`
```
"Build a Next.js 14 web app with:
1. App Router structure
2. Server Components for [pages]
3. API routes for [endpoints]
4. Authentication with NextAuth
5. Responsive design with Tailwind CSS
6. SEO optimization"
```

**Deliverables:** Web application, landing pages, dashboard

---

### Phase 5: Infrastructure & Deployment (Week 7)

**Agent:** `devops-engineer.md`
```
"Set up production infrastructure:
1. Design AWS/GCP architecture
2. Create Terraform configurations
3. Set up Kubernetes cluster
4. Build CI/CD pipeline (GitHub Actions)
5. Configure monitoring with Prometheus/Grafana
6. Implement auto-scaling"
```

**Deliverables:** Infrastructure as Code, CI/CD pipelines, monitoring dashboards

---

### Phase 6: Marketing & Launch (Week 8+)

#### Marketing Strategy
**Agent:** `marketing-growth.md`
```
"Create a go-to-market strategy:
1. Define customer acquisition channels
2. Create content marketing plan
3. Set up email campaigns
4. Design social media strategy
5. Plan paid advertising (Google Ads, Meta Ads)
6. Create analytics dashboard"
```

#### SEO Optimization
**Agent:** `seo-specialist.md`
```
"Optimize my website for search engines:
1. Perform keyword research for [industry]
2. Optimize on-page SEO (titles, meta, headers)
3. Fix technical SEO issues
4. Create content strategy for SEO
5. Build backlinks strategy"
```

**Deliverables:** Marketing plan, SEO audit, content calendar

---

## 💼 Common Use Cases

### Use Case 1: Building a SaaS Product

**Step-by-step agent usage:**

1. **Product Manager** → Define MVP features, user stories
2. **UI/UX Designer** → Design user flows, mockups
3. **Backend Architect** → Build APIs, database
4. **Web Frontend Expert** → Build web dashboard
5. **DevOps Engineer** → Deploy to production
6. **Marketing & Growth** → Acquire users
7. **SEO Specialist** → Drive organic traffic

### Use Case 2: Building a Mobile App

**Step-by-step agent usage:**

1. **Product Manager** → Create PRD, define features
2. **UI/UX Designer** → Design app screens
3. **Backend Architect** → Build API backend
4. **Flutter Expert** OR **React Native Expert** → Build mobile app
5. **DevOps Engineer** → Set up CI/CD, deploy backend
6. **Marketing & Growth** → App Store Optimization, user acquisition
7. **SEO Specialist** → Optimize landing page

### Use Case 3: Adding a New Feature

**Quick workflow:**

1. **Product Manager** → Write feature spec
2. **UI/UX Designer** → Design new screens/components
3. **Backend Architect** → Add API endpoints (if needed)
4. **Flutter/RN/Web Expert** → Implement frontend
5. **DevOps Engineer** → Deploy updates

### Use Case 4: Debugging & Optimization

| Problem | Agent | Prompt |
|---------|-------|--------|
| Slow API response | Backend Architect | "My API is slow. Help me optimize database queries and add caching" |
| Poor mobile performance | Flutter/RN Expert | "My app is laggy. Help me optimize performance" |
| Low conversion rate | UI/UX Designer | "Users aren't signing up. Analyze my onboarding flow" |
| No organic traffic | SEO Specialist | "My site has no traffic. Perform SEO audit and fix issues" |
| High infrastructure costs | DevOps Engineer | "Reduce my AWS costs while maintaining performance" |

---

## 🎓 How to Write Effective Prompts

### ❌ Bad Prompt
```
"Build an app"
```

### ✅ Good Prompt
```
"I'm building a task management app for small teams.

Context:
- Target users: Small businesses (5-20 people)
- Key features: Tasks, projects, team collaboration
- Platforms: Web (primary), Mobile (secondary)

Help me:
1. Design the system architecture
2. Create database schema for users, projects, and tasks
3. Build REST APIs for CRUD operations
4. Implement real-time updates with WebSockets

Tech stack: Go backend, PostgreSQL, Redis, Next.js frontend"
```

### Prompt Template

```markdown
I'm building [app name] for [target users].

Context:
- Purpose: [what problem it solves]
- Target audience: [who uses it]
- Key features: [main features]
- Platforms: [web/mobile/both]
- Current stage: [idea/MVP/growth]

Help me:
1. [Specific task 1]
2. [Specific task 2]
3. [Specific task 3]

Tech stack: [if decided]
Constraints: [budget, timeline, etc.]
```

---

## 🔀 Agent Collaboration Patterns

### Pattern 1: Sequential (One after another)
```
Product Manager → UI/UX Designer → Backend Architect → Flutter Expert
```
Use when: Each step depends on previous work

### Pattern 2: Parallel (At the same time)
```
Backend Architect + Flutter Expert + Web Frontend Expert
                    ↓
              DevOps Engineer
```
Use when: Teams work independently on different parts

### Pattern 3: Iterative (Loop back)
```
Product Manager → Designer → Developer → User Testing → Product Manager
```
Use when: You need to refine based on feedback

---

## 📊 Decision Tree: Which Agent to Use?

```
Start: What do you need help with?
│
├─ 📋 Define WHAT to build?
│  └─ Use: Product Manager
│
├─ 🎨 Design HOW it looks?
│  └─ Use: UI/UX Designer
│
├─ ⚙️ Build the BACKEND?
│  └─ Use: Backend Architect
│
├─ 📱 Build MOBILE app?
│  ├─ Cross-platform (iOS + Android) → Use: Flutter Expert
│  └─ Need native modules → Use: React Native Expert
│
├─ 🌐 Build WEBSITE?
│  └─ Use: Web Frontend Expert
│
├─ 🚀 DEPLOY to production?
│  └─ Use: DevOps Engineer
│
├─ 📈 Get MORE USERS?
│  └─ Use: Marketing & Growth
│
└─ 🔍 Improve SEARCH rankings?
   └─ Use: SEO Specialist
```

---

## 💡 Pro Tips

### 1. Start with Product Manager
Always begin with product planning before jumping into code:
```
❌ Don't: "Build me a chat app" → Start coding immediately
✅ Do: Product Manager → Define requirements → Then code
```

### 2. Design Before Development
Get UI/UX right before building:
```
❌ Don't: Build features → Then design UI
✅ Do: Design mockups → Get approval → Then implement
```

### 3. Use Multiple Agents in Same Session
You can switch between agents in one conversation:
```
"@product-manager: Create user stories for authentication

@uiux-designer: Design login screen based on those user stories

@backend-architect: Build the authentication API"
```

### 4. Reference Previous Work
Agents can build on each other's work:
```
"Based on the API design from Backend Architect,
help me integrate it into my Flutter app"
```

### 5. Ask for Best Practices
Each agent knows industry standards:
```
"What are the security best practices for API authentication?"
"Show me the proper way to structure a Flutter project"
"What's the recommended CI/CD pipeline for Go apps?"
```

---

## 🎯 Quick Start Scenarios

### Scenario 1: "I have an app idea"
```
1. Talk to Product Manager - Create PRD
2. Talk to UI/UX Designer - Design mockups
3. Get estimates from technical agents
4. Plan your timeline
```

### Scenario 2: "I'm ready to build"
```
1. Backend Architect - Set up backend
2. Flutter/RN/Web Expert - Build frontend
3. Connect frontend to backend
4. Test integration
```

### Scenario 3: "I need to launch"
```
1. DevOps Engineer - Deploy to production
2. Marketing & Growth - Create launch plan
3. SEO Specialist - Optimize for search
4. Monitor metrics
```

### Scenario 4: "I need more users"
```
1. Marketing & Growth - Analyze funnel, create campaigns
2. SEO Specialist - Improve organic traffic
3. UI/UX Designer - Optimize conversion
4. Product Manager - Add viral features
```

---

## 📝 Example Conversation Flow

```markdown
You: I want to build a fitness tracking app

Product Manager: Let me help you define the MVP...
[Creates PRD with user stories, prioritized features]

You: Great! Now I need the design

UI/UX Designer: Based on the PRD, here are the key screens...
[Provides wireframes, design system, mockups]

You: Perfect. Let's build the backend

Backend Architect: I'll design the system architecture...
[Provides database schema, API design, Go code]

You: Now the mobile app

Flutter Expert: I'll create a Flutter app with...
[Provides Flutter project structure, state management, screens]

You: How do I deploy this?

DevOps Engineer: Here's the deployment strategy...
[Provides Terraform configs, CI/CD pipeline, K8s configs]

You: How do I get users?

Marketing & Growth: Here's your go-to-market strategy...
[Provides marketing plan, ad campaigns, ASO strategy]

You: How do I rank on Google?

SEO Specialist: Let me audit your site and...
[Provides SEO audit, keyword strategy, optimization plan]
```

---

## 🔧 Troubleshooting

### "I don't know which agent to use"
→ Ask Product Manager to help you break down the problem first

### "The agent doesn't understand my request"
→ Provide more context: target users, tech stack, specific requirements

### "I need help from multiple agents"
→ Start a conversation, then reference agents as needed

### "The code doesn't work"
→ Go back to the specific agent with error messages and context

### "I need to modify existing code"
→ Show the agent your current code and explain what you want to change

---

## 📚 Learning Resources

Each agent file contains:
- ✅ Best practices from industry leaders
- ✅ Code examples and templates
- ✅ Checklists and guidelines
- ✅ Common patterns and anti-patterns
- ✅ Tool recommendations

Read the agent files to deepen your understanding!

---

## 🎓 Advanced Usage

### Multi-Agent Projects
For complex projects, coordinate multiple agents:

```markdown
## Week 1-2: Planning Phase
@product-manager: Create comprehensive PRD
@uiux-designer: Design complete user flows

## Week 3-4: Development Phase
@backend-architect: Build API infrastructure
@web-frontend-expert: Build marketing site
@flutter-expert: Start mobile app

## Week 5: Infrastructure
@devops-engineer: Set up production environment

## Week 6-8: Launch
@marketing-growth: Execute launch plan
@seo-specialist: Optimize for search engines
```

### Continuous Improvement
Use agents in an ongoing cycle:

```
Launch → Monitor → Analyze → Improve → Repeat
           ↓         ↓         ↓
    DevOps    Analytics   Product Manager
                           UI/UX Designer
                           Developers
```

---

## 🎯 Success Metrics

Track these metrics with each agent's help:

| Agent | Metrics to Track |
|-------|-----------------|
| Product Manager | Feature adoption, user satisfaction, NPS |
| UI/UX Designer | Task completion rate, time on task, bounce rate |
| Backend Architect | API latency, error rate, uptime |
| Mobile Developers | App store rating, crash rate, session length |
| Web Frontend | Core Web Vitals, conversion rate, page load time |
| DevOps | Deployment frequency, MTTR, infrastructure costs |
| Marketing & Growth | CAC, LTV, conversion rate, MRR |
| SEO Specialist | Organic traffic, keyword rankings, backlinks |

---

## 🚀 Ready to Start?

1. **Pick your starting point** from the Decision Tree above
2. **Write a clear prompt** using the template
3. **Follow the agent's guidance** and ask questions
4. **Iterate and improve** based on results
5. **Move to the next agent** when ready

Remember: These agents are here to help you build amazing products. Don't hesitate to ask questions, request clarifications, or dive deep into any topic!

---

## 📞 Quick Command Reference

```bash
# Start a planning session
@product-manager "Help me plan [app idea]"

# Get design help
@uiux-designer "Design [specific screen/flow]"

# Backend development
@backend-architect "Build API for [feature]"

# Mobile development
@flutter-expert "Implement [feature] in Flutter"
@react-native-expert "Create [screen] in React Native"

# Web development
@web-frontend-expert "Build [page] with Next.js"

# Deploy and scale
@devops-engineer "Set up [infrastructure/pipeline]"

# Grow your product
@marketing-growth "Create strategy for [goal]"
@seo-specialist "Optimize [page/site] for SEO"
```

Good luck building your product! 🚀
