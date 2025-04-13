import type { Database } from "./db/database.types";

type TripPlanRow = Database["public"]["Tables"]["trip_plans"]["Row"];
type GenerationErrorLogRow = Database["public"]["Tables"]["generation_error_logs"]["Row"];

// Common types
export interface PaginationResponse {
  current_page: number;
  total_pages: number;
  total_items: number;
}

export interface ErrorResponse {
  error: {
    code: string;
    message: string;
    details?: {
      field: string;
      message: string;
    }[];
  };
}

// Trip source type
export type TripSource = "ai-full" | "ai-edited" | "manual";

// Trip Plans DTOs
export interface CreateTripPlanDto {
  country: string;
  plans: string;
  activities?: string | null;
  source: TripSource;
  generation_id?: number | null;
}

export interface CreateTripPlansRequestDto {
  trips: CreateTripPlanDto[];
}

export interface CreateTripPlansResponseDto {
  created: Pick<TripPlanRow, "id" | "country" | "plans" | "activities" | "source" | "generation_id" | "created_at">[];
  failed: {
    index: number;
    error: string;
  }[];
}

export interface ListTripPlansQueryDto {
  page?: number;
  per_page?: number;
  sort?: "created_at" | "country";
  order?: "asc" | "desc";
}

export interface ListTripPlansResponseDto {
  trips: Pick<TripPlanRow, "id" | "country" | "plans" | "activities" | "source" | "created_at">[];
  pagination: PaginationResponse;
}

export type TripPlanDto = Pick<
  TripPlanRow,
  "id" | "country" | "plans" | "activities" | "source" | "created_at" | "updated_at"
>;

export type UpdateTripPlanDto = Pick<TripPlanRow, "country" | "plans" | "activities">;

// AI Generation DTOs
export interface GenerateTripPlanRequestDto {
  country: string;
  plans: string;
  activities?: string;
}

export interface GenerateTripPlanResponseDto {
  generation_id: number;
  plans: {
    country: string;
    plans: string;
    activities?: string | null;
    source: "ai-full";
  }[];
  metrics: {
    generation_duration: number;
    source_text_length: number;
  };
}

export interface ListGeneratedTripsQueryDto {
  limit?: number;
  offset?: number;
  sort?: "created_at_desc" | "created_at_asc";
}

export interface ListGeneratedTripsResponseDto {
  total: number;
  items: {
    generation_id: number;
    country: string;
    plans: string;
    activities?: string | null;
    source: "ai-full";
  }[];
}

export type GenerationErrorLogDto = Pick<
  GenerationErrorLogRow,
  "id" | "model" | "error_code" | "error_message" | "source_text_length" | "created_at"
>;

// Validation constants
export const VALIDATION_RULES = {
  COUNTRY_MIN_LENGTH: 2,
  COUNTRY_MAX_LENGTH: 50,
  PLANS_MIN_LENGTH: 1000,
  PLANS_MAX_LENGTH: 10000,
  ACTIVITIES_MAX_LENGTH: 2000,
} as const;
