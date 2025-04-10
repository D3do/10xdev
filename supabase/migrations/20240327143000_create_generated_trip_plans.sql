-- Migration: Create Generated Trip Plans Table
-- Description: Creates the generated_trip_plans table with indexes and RLS policies
-- Author: AI Assistant
-- Date: 2024-03-27

-- Enable required extensions
create extension if not exists "uuid-ossp";

-- Create generated_trip_plans table
create table generated_trip_plans (
    id bigserial primary key,
    user_id uuid not null references auth.users(id),
    model varchar(50) not null,
    accepted_unedited_count integer,
    accepted_edited_count integer,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    generation_duration integer not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

comment on table generated_trip_plans is 'Stores metadata about AI-generated trip plans';

-- Create indexes
create index idx_generated_trip_plans_user_id on generated_trip_plans(user_id);
create index idx_generated_trip_plans_source_text_hash on generated_trip_plans(source_text_hash);

-- Enable Row Level Security
alter table generated_trip_plans enable row level security;

-- Create RLS policies
create policy "Users can view their own generated trip plans"
    on generated_trip_plans for select
    using (auth.uid() = user_id);

create policy "Users can insert their own generated trip plans"
    on generated_trip_plans for insert
    with check (auth.uid() = user_id);

create policy "Users can update their own generated trip plans"
    on generated_trip_plans for update
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

create policy "Users can delete their own generated trip plans"
    on generated_trip_plans for delete
    using (auth.uid() = user_id); 