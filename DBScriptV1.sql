DROP DATABASE IF EXISTS olls;
GO

CREATE DATABASE olls;
GO

USE olls;

CREATE TABLE user_roles (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(MAX)
);

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    gender VARCHAR(10),
    mobile VARCHAR(20),
    role_id INT,
	avatar TEXT,
    status VARCHAR(50) DEFAULT 'pending_verification',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (role_id) REFERENCES user_roles(id)
);

CREATE TABLE settings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value VARCHAR(MAX),
    description VARCHAR(MAX)
);

CREATE TABLE blog_categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(MAX),
    is_active BIT DEFAULT 1
);

CREATE TABLE blogs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content VARCHAR(MAX),
    blog_category_id INT,
    author_id INT,
	thumbnail_url TEXT,
    status VARCHAR(50) DEFAULT 'draft',
    published_at DATETIME NULL DEFAULT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (blog_category_id) REFERENCES blog_categories(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE sliders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    link_url VARCHAR(255),
    title VARCHAR(255),
    description VARCHAR(MAX),
    status VARCHAR(50) DEFAULT 'active',
    order_number INT DEFAULT 0
);

CREATE TABLE course_categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(MAX),
    is_active BIT DEFAULT 1
);

CREATE TABLE courses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INT,
    description VARCHAR(MAX),
    status VARCHAR(50) DEFAULT 'draft',
    is_featured BIT DEFAULT 0,
    owner_id INT,
	thumbnail_url TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES course_categories(id),
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

CREATE TABLE price_packages (
    id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT,
    name VARCHAR(100) NOT NULL,
    duration_months INT NOT NULL CHECK (duration_months > 0),
    list_price DECIMAL(10, 2) NOT NULL CHECK (list_price >= 0),
    sale_price DECIMAL(10, 2) CHECK (sale_price >= 0),
    status VARCHAR(50) DEFAULT 'active',
    description VARCHAR(MAX),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE lesson_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(MAX)
);

CREATE TABLE test_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(MAX)
);

CREATE TABLE question_levels (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(MAX)
);

CREATE TABLE quizzes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT,
    test_type_id INT,
    name VARCHAR(255) NOT NULL,
    exam_level_id INT,
    duration_minutes INT,
    pass_rate_percentage DECIMAL(5, 2),
    description VARCHAR(MAX),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (test_type_id) REFERENCES test_types(id),
    FOREIGN KEY (exam_level_id) REFERENCES question_levels(id)
);

CREATE TABLE lessons (
    id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT,
    lesson_type_id INT,
    name VARCHAR(255) NOT NULL,
    topic VARCHAR(255),
    order_number INT DEFAULT 0,
    video_url VARCHAR(255),
    html_content VARCHAR(MAX),
    quiz_id INT NULL,
    status VARCHAR(50) DEFAULT 'active',
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (lesson_type_id) REFERENCES lesson_types(id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

CREATE TABLE questions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT,
    lesson_id INT NULL,
    question_level_id INT,
    status VARCHAR(50) DEFAULT 'draft',
    content VARCHAR(MAX) NOT NULL,
    media_url VARCHAR(255),
    explanation VARCHAR(MAX),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (lesson_id) REFERENCES lessons(id),
    FOREIGN KEY (question_level_id) REFERENCES question_levels(id)
);

CREATE TABLE answer_options (
    id INT IDENTITY(1,1) PRIMARY KEY,
    question_id INT,
    content VARCHAR(MAX) NOT NULL,
    is_correct BIT DEFAULT 0,
    order_number INT DEFAULT 0,
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE registrations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    course_id INT,
    package_id INT,
    registration_time DATETIME NOT NULL DEFAULT GETDATE(),
    total_cost DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    valid_from DATE,
    valid_to DATE,
    notes VARCHAR(MAX),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (package_id) REFERENCES price_packages(id)
);

CREATE TABLE quiz_attempts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    quiz_id INT,
    start_time DATETIME NOT NULL DEFAULT GETDATE(),
    end_time DATETIME NULL DEFAULT NULL,
    score DECIMAL(5, 2) NULL,
    status VARCHAR(50) DEFAULT 'in_progress',
    result VARCHAR(50) NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

CREATE TABLE quiz_attempt_answers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    attempt_id INT,
    question_id INT,
    selected_answer_option_id INT NULL,
    time_taken_seconds INT NULL,
    marked_for_review BIT DEFAULT 0,
    is_correct BIT NULL,
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (selected_answer_option_id) REFERENCES answer_options(id)
);