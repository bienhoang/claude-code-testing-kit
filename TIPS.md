## 📖 CẨM NANG SỬ DỤNG ANTIGRAVITY TỐI ƯU QUOTA TRONG AUTOMATION TESTING

Để tối ưu hóa thời gian sử dụng, không bị vướng giới hạn quota giữa chừng và vẫn đạt hiệu suất lập trình cao nhất, hãy áp dụng chiến thuật **"Chia Để Trị"** – dùng đúng Mode (chế độ) và đúng Model (mô hình AI) cho từng loại task.

### 1. Phân bổ công việc theo Chế Độ (Mode)
Lưu ý quan trọng: **Planning Mode tiêu tốn số lượng Token lớn nhất**. Nó đọc rộng, suy nghĩ nhiều bước và tự động lặp lại quy trình.

*   **Dùng PLANNING MODE cho Tác vụ Nền tảng (Big Tasks):**
    *   Khởi tạo một Automation Framework mới (setup thư mục, Base Test, Report).
    *   Xây dựng kiến trúc Page Object Model (POM) cho module chức năng hoàn toàn mới.
    *   Viết một luồng End-to-End (E2E) Test phức tạp chạy qua nhiều page và thay đổi nhiều trạng thái.
*   **Chuyển về FAST MODE cho Tác vụ Bảo trì (Daily Tasks):**
    *   Sau khi "dựng khung" xong ở Planning, hãy lập tức tắt nó đi.
    *   Dùng Fast Mode để chạy việc hàng ngày: bổ sung thêm test case, update locators bị đổi, tối ưu lại các hàm (methods) hoặc refactor code cục bộ.

### 2. Chiến thuật lựa chọn AI Models (Theo độ khó)
Code ưu tiên Claude, nhưng hãy biết cách phân bổ cho các Model khác để bảo vệ quota.

*   ⭐⭐⭐ **Claude Sonnet / Opus (Bộ óc Tinh nhuệ):**
    *   **Nhiệm vụ:** Giải quyết các logic Code khó và Fix Bug hóc búa.
    *   **Automation Testing:** Dùng để xử lý các bài toán như lấy element trong Shadow DOM, tương tác iFrame lồng nhau, xử lý bất đồng bộ (Async/await), kéo thả (Drag-and-Drop) hoặc các test case đang chạy chập chờn (Flaky). 
    *   *Lưu ý: Token của Claude rất nhanh cạn, chỉ dùng khi thật sự "kẹt".*
*   ⭐⭐ **Gemini Pro (Cỗ máy Bảo trì):**
    *   **Nhiệm vụ:** Cán đáng công việc code "phổ thông". 
    *   **Automation Testing:** Sửa lỗi locator sai ID/Class, thêm một vài bước verify/assertions đơn giản, thay đổi data cứng thành biến linh hoạt. Giải quyết cực tốt các lỗi rõ ràng và đã biết nguyên nhân.
*   ⭐ **Gemini Flash / Claude Haiku (Sát thủ Tốc độ & Tiết kiệm):**
    *   **Nhiệm vụ:** Xử lý văn bản, Data và đọc Log (nhanh, thẻ Context dài nhưng cực kỳ rẻ). 
    *   **Automation Testing:** 
        *   Phân tích cục Log CI/CD ngàn dòng để chỉ ra duy nhất 1 dòng gây lỗi `AssertionError`.
        *   Đọc thẻ HTML lớn và bóc tách cấu trúc để xuất ra Table locators.
        *   Sinh hàng trăm dòng Mock Data (JSON, CSV, Tài khoản giả) cho Data-Driven Testing.
        *   Tạo tài liệu (Test Document), viết Git Commit messages, soạn Javadoc / Docstrings. Trình bày nội dung định dạng chuẩn SEO.

### 3. Các Tip "Nhỏ mà Có Võ" để hạn chế tốn Token
*   **Tránh đưa rác vào Context:** Thay vì copy toàn bộ thẻ `<body>` của giao diện web đổ vào chat, hãy dùng Inspect trong trình duyệt và chỉ copy đúng thẻ `<div>` biểu diễn khối thông tin (Table / Form / Dropdown) đang cần xử lý.
*   **Định vị không gian làm việc:** Luôn `@mention` chỉ đúng file Test và file Page Object đang làm dở khi nhờ AI fix code (ví dụ: gõ tên `@LoginTest` và `@LoginPage`). Việc này cản AI đọc cả project mất thì giờ.
*   **Hỏi cùng Stack Trace:** Khi Script lỗi (ví dụ: ElementNotVisible), đừng quăng nguyên file code lên hỏi mù. Hãy copy dòng "Báo lỗi thực tế" in ra ở Terminal ghép cùng đoạn Code bị hỏng thả vào Fast Mode – AI sẽ đánh đúng trọng tâm ngay lập tức.