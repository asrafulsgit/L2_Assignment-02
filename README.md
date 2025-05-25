# Bonus Section (PostgreSQL)

---

## 1. What is PostgreSQL?

PostgreSQL হচ্ছে একটি ওপেন-সোর্স রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি SQL ব্যবহার করে ডেটাবেজে ডেটা create, read, update, delete করার সুবিধা দেয়। এটি একটি প্রোগ্রামিং ভাষা নয়, বরং একটি ডেটাবেজ সিস্টেম, যা SQL কুয়েরি ভাষা ব্যবহার করে পরিচালিত হয়।

নিচে কিছু সাধারণ কুয়েরির উদাহরণ দেওয়া হলো:

**data write**  
```sql
INSERT INTO rangers (ranger_id,name,region) VALUES (4,'Derek Fox','Coastal Plains')
```

**data read**  
```sql
SELECT * FROM rangers;
```

**data update**  
```sql
UPDATE species  
    SET conservation_status = 'Historic'
    WHERE extract(year FROM discovery_date) < 1800;
```

**data delete**  
```sql
DELETE FROM rangers 
    WHERE ranger_id NOT IN(
        SELECT ranger_id FROM sightings
    );
```

---

## 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

**Primary Key :** প্রাইমারি কী হচ্ছে একটি লোকাল কী যা কোন একটি নির্দিষ্ট টেবিলের কোন রো কে ইউনিক ভাবে খুঁজতে সাহায্য করে। একটি টেবিলের প্রত্যেকটি রো এর প্রাইমারি কী গুলো অবশ্যই ইউনিক থাকতে হবে।

নিচে একটি টেবিলের মাধ্যমে প্রাইমারি কী দেখানো হলো:

| student_id | name    | email            |
|------------|---------|------------------|
| 1          | asraful | asraful@gmail.com|
| 2          | karim   | karim@gmail.com  |
| 3          | faisal  | faisal@gmail.com |

উপরের টেবিলে স্টুডেন্ট আইডি হচ্ছে একটি প্রাইমারি কী যা প্রত্যেকটি স্টুডেন্টের ডাটা কে ইউনিকভাবে খুঁজতে সাহায্য করে।

**Foreign Key :** ফরেন কী হচ্ছে এমন একটি কী যা অন্য কোন টেবিলের প্রাইমারি কী। যার মাধ্যমে অন্য কোন টেবিলের ডাটা রিড করা যায়।

নিচে টেবিলের মাধ্যমে ফরেন কী দেখানো হলো:

**Courses Table:**  
| course_id(PK) | course_name | course_duraction |
|---------------|-------------|------------------|
| 1             | frontend    | 6 month          |
| 2             | backend     | 6 month          |
| 3             | devops      | 4 month          |

**Students Table:**  
| student_id(PK) | name    | email             | course_id(FK) |
|----------------|---------|-------------------|---------------|
| 1              | asraful | asraful@gmail.com | 1             |
| 2              | karim   | karim@gmail.com   | 2             |
| 3              | faisal  | faisal@gmail.com  | 1             |

উপরের কোর্স টেবিলের প্রাইমারি কী স্টুডেন্ট টেবিলে ফরেন কী হিসেবে ব্যবহার করা হয়েছে। উপরের স্টুডেন্ট টেবিলের স্টুডেন্ট তার কোর্স আইডি দিয়ে সে তার কোর্সের ডিটেল সম্পর্কে জানতে পারে।

---

## 3. What is the difference between the VARCHAR and CHAR data types?

PostgreSQL এর মধ্যে  VARCHAR এবং CHAR এই দুইটি string ডাটা সংরক্ষণ করার জন্য ব্যবহার করা হয়ে থাকে।

নিচে এই দুটির পার্থক্য আলোচনা করা হলো:

### CHAR :
1. CHAR যতটুকু দৈর্ঘ্য দিয়ে ডিফাইন করা হয় সে মেমোরিতে ততটুকু দৈর্ঘ্য জায়গা দখল করে।
2. দৈর্ঘ্য অনুযায়ী ভ্যালু না দেওয়া থাকলে সে বাকি জায়গাগুলো ফাঁকা রেখে মেমরি দখল করে রাখে।
3. দক্ষতা খুবই কম।

### VARCHAR:
1. যতটুকু দৈর্ঘ্য দিয়ে ডিফাইন করা হয় ততটুকু দৈর্ঘ্য সম্পূর্ণরূপে মেমোরি থেকে দখল না করে যতটুকু ভ্যালু পাওয়া যায় ততটুকু মেমোরি দখল করে।
2. প্রকৃত ভ্যালুর বাইরে কোন ফাঁকা জায়গা রাখে না।
3. দক্ষতা অনেক বেশি।

---

## 4. Explain the purpose of the WHERE clause in a SELECT statement.

WHERE ক্লজ এরপরে যেই কন্ডিশনটি দেওয়া হয় তা পুরো টেবিলের সকল রো ম্যাপিং করে ওই কন্ডিশন অনুসারে যে  রো গুলো পাওয়া যায় তা নিয়ে কাজ করে।

নিচে এর একটি উদাহরণ দেওয়া হল:

```sql
SELECT * FROM employees WHERE emp_age > 50;
```

উপরের কুয়েরির মাধ্যমে employees টেবিলের যে employee গুলো বয়স ৫০ এর বেশি ওই  employee গুলোকে দেখানো হবে।

---

## 5. What are the LIMIT and OFFSET clauses used for?

### LIMIT:

LIMIT clause হচ্ছে এমন একটি clause যার মাধ্যমে প্রাপ্ত রো গুলো হতে কতটি রো দেখানো হবে তা নির্দিষ্ট করা হয়।

নিচে এর একটি উদাহরণ দেওয়া হল:

```sql
SELECT * FROM students WHERE department = 'CST' LIMIT 5;
```

উপরের কুয়েরিতে স্টুডেন্ট টেবল হতে CST ডিপার্টমেন্টের মোট স্টুডেন্ট হতে প্রথম পাঁচটি স্টুডেন্টকে দেখানো হবে।

### OFFSET:

OFFSET clause হচ্ছে এমন একটি clause যার মাধ্যমে প্রাপ্ত রো গুলো হতে কত নাম্বার রো থেকে রো গুলো দেখানো হবে তা নির্দিষ্ট করে। অর্থাৎ এর মাধ্যমে প্রাপ্ত রো গুলো এর মধ্য হতে কতগুলো রো বাকি রেখে দেখানো হবে তা নির্দিষ্ট করে।

নিচে এর একটি উদাহরণ দেওয়া হল:

```sql
SELECT * FROM products WHERE discount > 50 OFFSET 10;
```

উপরের কুয়েরিতে products টেবিল হতে যে প্রোডাক্টগুলোর ডিসকাউন্ট ৫০% এর উপরে ওই প্রোডাক্ট গুলোর মধ্য থেকে প্রথম ১০ টি প্রোডাক্ট কে বাদ দিয়ে পরবর্তী প্রোডাক্ট গুলো দেখানো হবে।

---

