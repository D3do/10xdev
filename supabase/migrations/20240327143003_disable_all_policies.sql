-- Migration: Disable All RLS Policies
-- Description: Disables all previously defined RLS policies for trip_plans, generated_trip_plans, and generation_error_logs
-- Author: AI Assistant
-- Date: 2024-03-27

-- Disable policies for generated_trip_plans
drop policy if exists "Users can view their own generated trip plans" on generated_trip_plans;
drop policy if exists "Users can insert their own generated trip plans" on generated_trip_plans;
drop policy if exists "Users can update their own generated trip plans" on generated_trip_plans;
drop policy if exists "Users can delete their own generated trip plans" on generated_trip_plans;

-- Disable policies for trip_plans
drop policy if exists "Users can view their own trip plans" on trip_plans;
drop policy if exists "Users can insert their own trip plans" on trip_plans;
drop policy if exists "Users can update their own trip plans" on trip_plans;
drop policy if exists "Users can delete their own trip plans" on trip_plans;

-- Disable policies for generation_error_logs
drop policy if exists "Users can view their own error logs" on generation_error_logs;
drop policy if exists "Users can insert their own error logs" on generation_error_logs; 