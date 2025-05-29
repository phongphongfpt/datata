-- Dữ liệu mẫu cho user_roles
SET IDENTITY_INSERT user_roles ON;
INSERT INTO user_roles (id, name, description) VALUES
(1, N'Guest', N'Người dùng chưa đăng ký có thể xem nội dung công khai.'),
(2, N'Customer', N'Người dùng đã đăng ký là khách hàng thực tế hoặc tiềm năng.'),
(3, N'Marketing', N'Thành viên bộ phận marketing của tổ chức.'),
(4, N'Sale', N'Thành viên bộ phận bán hàng của tổ chức.'),
(5, N'Expert', N'Truy cập và chuẩn bị nội dung khóa học/bài kiểm tra theo phân công của quản trị viên.'),
(6, N'Admin', N'Người lãnh đạo/quản lý tổ chức, đóng vai trò quản trị viên hệ thống.');
SET IDENTITY_INSERT user_roles OFF;

-- Dữ liệu mẫu cho users
SET IDENTITY_INSERT users ON;
INSERT INTO users (id, email, password_hash, full_name, gender, mobile, role_id, avatar, status, created_at, updated_at) VALUES
(1, 'admin@olls.com', 'hashed_password_admin_1', N'Admin User', N'Male', '0901234567', 6, N'avatar_admin1.jpg', N'active', GETDATE(), GETDATE()),
(2, 'expert1@olls.com', 'hashed_password_expert_1', N'Expert One', N'Female', '0902345678', 5, N'avatar_expert1.jpg', N'active', GETDATE(), GETDATE()),
(3, 'expert2@olls.com', 'hashed_password_expert_2', N'Expert Two', N'Male', '0903456789', 5, N'avatar_expert2.jpg', N'active', GETDATE(), GETDATE()),
(4, 'customer1@example.com', 'hashed_password_customer_1', N'Customer One', N'Female', '0911223344', 2, N'avatar_customer1.jpg', N'active', GETDATE(), GETDATE()),
(5, 'customer2@example.com', 'hashed_password_customer_2', N'Customer Two', N'Male', '0912334455', 2, N'avatar_customer2.jpg', N'pending_verification', GETDATE(), GETDATE()),
(6, 'marketing1@olls.com', 'hashed_password_marketing_1', N'Marketing Staff', N'Female', '0921234567', 3, N'avatar_marketing1.jpg', N'active', GETDATE(), GETDATE()),
(7, 'sale1@olls.com', 'hashed_password_sale_1', N'Sales Staff', N'Male', '0931234567', 4, N'avatar_sale1.jpg', N'active', GETDATE(), GETDATE()),
(8, 'guest1@example.com', 'hashed_password_guest_1', N'Guest User', N'Male', NULL, 1, NULL, N'active', GETDATE(), GETDATE());
SET IDENTITY_INSERT users OFF;

-- Dữ liệu mẫu cho settings
SET IDENTITY_INSERT settings ON;
INSERT INTO settings (id, setting_key, setting_value, description) VALUES
(1, N'site_name', N'Hệ thống học tiếng Anh trực tuyến', N'Tên của trang web.'),
(2, N'contact_email', N'contact@olls.com', N'Email liên hệ chính của hệ thống.'),
(3, N'items_per_page', N'10', N'Số lượng mục mặc định hiển thị trên mỗi trang.');
SET IDENTITY_INSERT settings OFF;

-- Dữ liệu mẫu cho blog_categories
SET IDENTITY_INSERT blog_categories ON;
INSERT INTO blog_categories (id, name, description, is_active) VALUES
(1, N'Tin tức giáo dục', N'Tin tức và cập nhật mới nhất trong lĩnh vực giáo dục.', 1),
(2, N'Mẹo học tập', N'Các mẹo và thủ thuật để học tập hiệu quả.', 1),
(3, N'Công nghệ trong học tập', N'Các bài viết về công nghệ mới trong giáo dục trực tuyến.', 1);
SET IDENTITY_INSERT blog_categories OFF;

-- Dữ liệu mẫu cho blogs
SET IDENTITY_INSERT blogs ON;
INSERT INTO blogs (id, title, content, blog_category_id, author_id, thumbnail_url, status, published_at, created_at, updated_at) VALUES
(1, N'Tương lai của giáo dục trực tuyến', N'Cái nhìn toàn diện về cách giáo dục trực tuyến đang phát triển.', 1, 1, N'blog_thumbnail_1.jpg', N'published', GETDATE(), GETDATE(), GETDATE()),
(2, N'Làm chủ quản lý thời gian cho các khóa học trực tuyến', N'Các chiến lược thực tế giúp sinh viên quản lý thời gian hiệu quả.', 2, 2, N'blog_thumbnail_2.jpg', N'published', GETDATE(), GETDATE(), GETDATE()),
(3, N'AI trong học tập: Cơ hội và thách thức', N'Khám phá tác động của Trí tuệ nhân tạo đối với việc học cá nhân hóa.', 3, 1, N'blog_thumbnail_3.jpg', N'draft', NULL, GETDATE(), GETDATE());
SET IDENTITY_INSERT blogs OFF;

-- Dữ liệu mẫu cho sliders
SET IDENTITY_INSERT sliders ON;
INSERT INTO sliders (id, image_url, link_url, title, description, status, order_number) VALUES
(1, N'slider1.jpg', N'/courses/popular', N'Khai phá tiềm năng của bạn', N'Khám phá các khóa học ngôn ngữ hàng đầu của chúng tôi.', N'active', 1),
(2, N'slider2.jpg', N'/promotions', N'Ưu đãi có thời hạn', N'Giảm 20% tất cả các khóa học ngôn ngữ cao cấp!', N'active', 2);
SET IDENTITY_INSERT sliders OFF;

-- Dữ liệu mẫu cho course_categories (đã điều chỉnh)
SET IDENTITY_INSERT course_categories ON;
INSERT INTO course_categories (id, name, description, is_active) VALUES
(1, N'Tiếng Anh', N'Các khóa học liên quan đến ngôn ngữ Anh.', 1),
(2, N'Tiếng Nhật', N'Các khóa học liên quan đến ngôn ngữ Nhật.', 1),
(3, N'Tiếng Hàn', N'Các khóa học liên quan đến ngôn ngữ Hàn.', 1),
(4, N'Tiếng Trung', N'Các khóa học liên quan đến ngôn ngữ Trung.', 1);
SET IDENTITY_INSERT course_categories OFF;

-- Dữ liệu mẫu cho courses (đã điều chỉnh)
SET IDENTITY_INSERT courses ON;
INSERT INTO courses (id, name, category_id, description, status, is_featured, owner_id, thumbnail_url, created_at, updated_at) VALUES
(1, N'Tiếng Anh cho người mới bắt đầu (A1)', 1, N'Học các kiến thức cơ bản về tiếng Anh cho người mới bắt đầu.', N'active', 1, 2, N'english_a1_thumbnail.jpg', GETDATE(), GETDATE()),
(2, N'Tiếng Nhật giao tiếp cơ bản (N5)', 2, N'Học giao tiếp cơ bản và ngữ pháp N5 tiếng Nhật.', N'active', 0, 3, N'japanese_n5_thumbnail.jpg', GETDATE(), GETDATE()),
(3, N'Luyện thi TOEIC', 1, N'Khóa học toàn diện để chuẩn bị cho kỳ thi TOEIC.', N'active', 1, 2, N'toeic_thumbnail.jpg', GETDATE(), GETDATE()),
(4, N'Tiếng Hàn trung cấp (Topic II)', 3, N'Nâng cao kỹ năng tiếng Hàn cho trình độ trung cấp và luyện thi Topic II.', N'draft', 0, 3, N'korean_topic2_thumbnail.jpg', GETDATE(), GETDATE()),
(5, N'Tiếng Trung thương mại', 4, N'Khóa học tiếng Trung tập trung vào các tình huống kinh doanh.', N'active', 0, 2, N'chinese_business_thumbnail.jpg', GETDATE(), GETDATE());
SET IDENTITY_INSERT courses OFF;

-- Dữ liệu mẫu cho price_packages
SET IDENTITY_INSERT price_packages ON;
INSERT INTO price_packages (id, course_id, name, duration_months, list_price, sale_price, status, description) VALUES
(1, 1, N'Gói cơ bản tiếng Anh A1', 3, 99.99, 79.99, N'active', N'3 tháng truy cập khóa tiếng Anh A1.'),
(2, 1, N'Gói cao cấp tiếng Anh A1', 12, 299.99, 249.99, N'active', N'12 tháng truy cập khóa tiếng Anh A1 với hỗ trợ cao cấp.'),
(3, 2, N'Gói tiêu chuẩn tiếng Nhật N5', 6, 149.99, 129.99, N'active', N'6 tháng truy cập khóa tiếng Nhật N5.'),
(4, 3, N'Gói luyện thi TOEIC', 6, 199.99, 179.99, N'active', N'6 tháng truy cập khóa luyện thi TOEIC.');
SET IDENTITY_INSERT price_packages OFF;

-- Dữ liệu mẫu cho lesson_types
SET IDENTITY_INSERT lesson_types ON;
INSERT INTO lesson_types (id, name, description) VALUES
(1, N'Video', N'Nội dung bài học chủ yếu qua video.'),
(2, N'Text', N'Nội dung bài học chủ yếu qua văn bản/HTML.'),
(3, N'Quiz', N'Bài học là một bài kiểm tra hoặc đánh giá.');
SET IDENTITY_INSERT lesson_types OFF;

-- Dữ liệu mẫu cho test_types
SET IDENTITY_INSERT test_types ON;
INSERT INTO test_types (id, name, description) VALUES
(1, N'Bài kiểm tra thực hành', N'Để tự đánh giá và luyện tập.'),
(2, N'Bài kiểm tra giữa kỳ', N'Đánh giá sự hiểu biết về một phần của khóa học.'),
(3, N'Bài kiểm tra cuối kỳ', N'Đánh giá toàn diện khóa học.');
SET IDENTITY_INSERT test_types OFF;

-- Dữ liệu mẫu cho question_levels
SET IDENTITY_INSERT question_levels ON;
INSERT INTO question_levels (id, name, description) VALUES
(1, N'Dễ', N'Các câu hỏi hiểu biết cơ bản.'),
(2, N'Trung bình', N'Các câu hỏi hiểu biết và ứng dụng trung cấp.'),
(3, N'Khó', N'Các câu hỏi giải quyết vấn đề nâng cao.');
SET IDENTITY_INSERT question_levels OFF;

-- Dữ liệu mẫu cho quizzes
SET IDENTITY_INSERT quizzes ON;
INSERT INTO quizzes (id, course_id, test_type_id, name, exam_level_id, duration_minutes, pass_rate_percentage, description) VALUES
(1, 1, 1, N'Bài kiểm tra tiếng Anh cơ bản 1', 1, 30, 70.00, N'Một bài kiểm tra ngắn về các kiến thức cơ bản tiếng Anh.'),
(2, 1, 2, N'Bài kiểm tra giữa kỳ tiếng Anh', 2, 60, 75.00, N'Đánh giá giữa kỳ cho khóa giới thiệu tiếng Anh.'),
(3, 3, 1, N'Bài tập ngữ pháp TOEIC', 2, 45, 60.00, N'Bài kiểm tra thực hành về các cấu trúc ngữ pháp TOEIC.');
SET IDENTITY_INSERT quizzes OFF;

-- Dữ liệu mẫu cho lessons
SET IDENTITY_INSERT lessons ON;
INSERT INTO lessons (id, course_id, lesson_type_id, name, topic, order_number, video_url, html_content, quiz_id, status) VALUES
(1, 1, 1, N'Giới thiệu về tiếng Anh', N'Bảng chữ cái và cách phát âm', 1, N'https://youtube.com/python_intro_video', NULL, NULL, N'active'),
(2, 1, 2, N'Chào hỏi và giới thiệu bản thân', N'Các câu chào hỏi cơ bản', 2, NULL, N'<p>Bài học này bao gồm các cách chào hỏi và giới thiệu bản thân...</p>', NULL, N'active'),
(3, 1, 3, N'Bài kiểm tra tiếng Anh cơ bản', N'Kiểm tra các bài 1-2', 3, NULL, NULL, 1, N'active'),
(4, 3, 1, N'Tổng quan về kỳ thi TOEIC', N'Cấu trúc và định dạng bài thi', 1, N'https://youtube.com/sql_select_video', NULL, NULL, N'active'),
(5, 3, 2, N'Ngữ pháp TOEIC: Thì', N'Các thì trong tiếng Anh và cách dùng trong TOEIC', 2, NULL, N'<p>Hiểu các thì trong tiếng Anh và cách áp dụng trong TOEIC...</p>', NULL, N'active'),
(6, 3, 3, N'Bài tập ngữ pháp TOEIC', N'Kiểm tra ngữ pháp TOEIC', 3, NULL, NULL, 3, N'active');
SET IDENTITY_INSERT lessons OFF;

-- Dữ liệu mẫu cho questions
SET IDENTITY_INSERT questions ON;
INSERT INTO questions (id, course_id, lesson_id, question_level_id, status, content, media_url, explanation) VALUES
(1, 1, 3, 1, N'active', N'Chọn câu trả lời đúng cho "How are you?"', NULL, N'Câu trả lời phổ biến cho "How are you?" là "I am fine, thank you."'),
(2, 1, 3, 1, N'active', N'Từ nào sau đây là danh từ số ít?', NULL, N'Apple là danh từ số ít, trong khi apples là số nhiều.'),
(3, 3, 6, 2, N'active', N'Chọn câu có lỗi ngữ pháp:', NULL, N'Câu đúng phải là "He goes to school every day."'),
(4, 3, 6, 2, N'active', N'Từ đồng nghĩa với "diligent" là gì?', NULL, N'Từ đồng nghĩa với "diligent" là "hard-working".');
SET IDENTITY_INSERT questions OFF;

-- Dữ liệu mẫu cho answer_options
SET IDENTITY_INSERT answer_options ON;
INSERT INTO answer_options (id, question_id, content, is_correct, order_number) VALUES
(1, 1, N'I am fine, thank you.', 1, 1),
(2, 1, N'I fine am, thank you.', 0, 2),
(3, 1, N'Thank you, I am fine.', 0, 3),
(4, 2, N'Apples', 0, 1),
(5, 2, N'Books', 0, 2),
(6, 2, N'Apple', 1, 3),
(7, 3, N'She is a doctor.', 0, 1),
(8, 3, N'He go to school every day.', 1, 2),
(9, 3, N'They are playing football.', 0, 3),
(10, 4, N'Lazy', 0, 1),
(11, 4, N'Careless', 0, 2),
(12, 4, N'Hard-working', 1, 3);
SET IDENTITY_INSERT answer_options OFF;

-- Dữ liệu mẫu cho registrations
SET IDENTITY_INSERT registrations ON;
INSERT INTO registrations (id, user_id, course_id, package_id, registration_time, total_cost, status, valid_from, valid_to, notes) VALUES
(1, 4, 1, 1, GETDATE(), 79.99, N'completed', GETDATE(), DATEADD(month, 3, GETDATE()), N'Khách hàng 1 đăng ký khóa tiếng Anh cơ bản.'),
(2, 5, 2, 3, GETDATE(), 129.99, N'pending', GETDATE(), DATEADD(month, 6, GETDATE()), N'Khách hàng 2 đang chờ thanh toán cho khóa tiếng Nhật.'),
(3, 4, 3, 4, GETDATE(), 179.99, N'completed', GETDATE(), DATEADD(month, 6, GETDATE()), N'Khách hàng 1 đăng ký khóa luyện thi TOEIC.');
SET IDENTITY_INSERT registrations OFF;

-- Dữ liệu mẫu cho quiz_attempts
SET IDENTITY_INSERT quiz_attempts ON;
INSERT INTO quiz_attempts (id, user_id, quiz_id, start_time, end_time, score, status, result) VALUES
(1, 4, 1, GETDATE(), DATEADD(minute, 20, GETDATE()), 85.00, N'completed', N'pass'),
(2, 4, 3, GETDATE(), DATEADD(minute, 30, GETDATE()), 70.00, N'completed', N'pass'),
(3, 5, 1, GETDATE(), NULL, NULL, N'in_progress', NULL);
SET IDENTITY_INSERT quiz_attempts OFF;

-- Dữ liệu mẫu cho quiz_attempt_answers
SET IDENTITY_INSERT quiz_attempt_answers ON;
INSERT INTO quiz_attempt_answers (id, attempt_id, question_id, selected_answer_option_id, time_taken_seconds, marked_for_review, is_correct) VALUES
(1, 1, 1, 1, 10, 0, 1),
(2, 1, 2, 6, 15, 0, 1),
(3, 2, 3, 8, 20, 0, 1),
(4, 2, 4, 12, 12, 0, 1),
(5, 3, 1, 2, 5, 0, 0); -- Câu trả lời sai cho lần thử đang tiến hành
SET IDENTITY_INSERT quiz_attempt_answers OFF;