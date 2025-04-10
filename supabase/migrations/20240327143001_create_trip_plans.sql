-- Migration: Create Trip Plans Table
-- Description: Creates the trip_plans table with indexes, trigger for updated_at, and RLS policies
-- Author: AI Assistant
-- Date: 2024-03-27

-- Create trip_plans table
create table trip_plans (
    id bigserial primary key,
    user_id uuid not null references auth.users(id),
    country varchar(50) not null,
    plans text not null,
    activities text,
    source varchar(20) not null check (source in ('ai-full', 'ai-edited', 'manual')),
    generation_id bigint references generated_trip_plans(id),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

comment on table trip_plans is 'Stores user trip plans, both AI-generated and manually created';

-- Create indexes
create index idx_trip_plans_user_id on trip_plans(user_id);
create index idx_trip_plans_generation_id on trip_plans(generation_id);

-- Create updated_at trigger function
create or replace function update_updated_at_column()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

-- Create trigger for trip_plans
create trigger update_trip_plans_updated_at
    before update on trip_plans
    for each row
    execute function update_updated_at_column();

-- Enable Row Level Security
alter table trip_plans enable row level security;

-- Create RLS policies
create policy "Users can view their own trip plans"
    on trip_plans for select
    using (auth.uid() = user_id);

create policy "Users can insert their own trip plans"
    on trip_plans for insert
    with check (auth.uid() = user_id);

create policy "Users can update their own trip plans"
    on trip_plans for update
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

create policy "Users can delete their own trip plans"
    on trip_plans for delete
    using (auth.uid() = user_id); 