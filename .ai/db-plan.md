# VibeTravels Database Schema

## 1. Tables

### 1.1. users

- **encrypted_password**: VARCHAR NOT NULL
- **created_at**: TIMESTAMPTZ NOT NULL DEFAULT now()
- **confirmed_at**: TIMESTAMPTZ NOT NULL DEFAULT now()

### 1.2. trip_plans

- **id**: BIGSERIAL, PRIMARY KEY
- **country**: VARCHAR(50) NOT NULL
- **plans**: TEXT NOT NULL
  - (Optional: Add a CHECK constraint to limit length if needed)
- **activities**: TEXT
- **source**: VARCHAR(20) NOT NULL, CHECK (source IN ('ai-full', 'ai-edited', 'manual'))
- **created_at**: TIMESTAMPTZ NOT NULL DEFAULT now()
- **updated_at**: TIMESTAMPTZ NOT NULL DEFAULT now()
- **generation_id**: BIGINT, FOREIGN KEY REFERENCES generated_trip_plans(id)
- **user_id**: UUID NOT NULL, FOREIGN KEY REFERENCES users(id)

_Additional:_
A trigger should be created on `trip_plans` to automatically update the `updated_at` column on modifications.

---

### 1.3. generated_trip_plans

- **id**: BIGSERIAL, PRIMARY KEY
- **user_id**: UUID NOT NULL, FOREIGN KEY REFERENCES users(id)
- **model**: VARCHAR(50) NOT NULL
- **accepted_unedited_count**: INTEGER NULLABLE
- **accepted_edited_count**: INTEGER NULLABLE
- **source_text_hash**: VARCHAR NOT NULL
- **source_text_length**: INTEGER NOT NULL, CHECK (source_text_length BETWEEN 1000 AND 10000)
- **generation_duration**: INTEGER NOT NULL
- **created_at**: TIMESTAMPTZ NOT NULL DEFAULT now()
- **updated_at**: TIMESTAMPTZ NOT NULL DEFAULT now()

---

### 1.4. generation_error_logs

- **id**: BIGSERIAL, PRIMARY KEY
- **user_id**: UUID NOT NULL, FOREIGN KEY REFERENCES users(id)
- **model**: VARCHAR NOT NULL
- **source_text_hash**: VARCHAR NOT NULL
- **source_text_length**: INTEGER NOT NULL, CHECK (source_text_length BETWEEN 1000 AND 10000)
- **error_code**: VARCHAR(100) NOT NULL
- **error_message**: TEXT NOT NULL

---

## 2. Relationships

- **trip_plans.user_id**, **generated_trip_plans.user_id**, and **generation_error_logs.user_id** reference the `users.id` (managed by Supabase).
- **trip_plans.generation_id** references `generated_trip_plans.id`, establishing a one-to-many relationship (one generated_trip_plans record can be associated with multiple trip_plans).

---

## 3. Indexes

- Create indexes on the `user_id` column in all tables for efficient user-based queries.
- Create an index on `trip_plans.generation_id` to optimize joins with `generated_trip_plans`.
- Optionally, create an index on `generated_trip_plans.source_text_hash` for faster queries based on the hash.

---

## 4. PostgreSQL RLS Policies

- Enable Row Level Security (RLS) on all tables (`trip_plans`, `generated_trip_plans`, `generation_error_logs`).
- Example policy for each table:
  ```sql
  CREATE POLICY user_isolation ON table_name
      USING (user_id = auth.uid());
  ```
- This ensures that authenticated users can only access records where `user_id` matches their own user identifier.

---

## 5. Additional Notes

- All primary keys are defined as `BIGSERIAL` to ensure scalability and uniqueness.
- Timestamps are managed with default values, and the `updated_at` column is automatically updated via a trigger in `trip_plans`.
- The schema is normalized to 3NF, ensuring minimal data redundancy while maintaining efficient query performance.
- The design allows for future extension, including auditing and soft-delete mechanisms if needed.
