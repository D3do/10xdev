# REST API Plan

## 1. Resources

### 1.1. Users

- Maps to Supabase auth.users table
- Managed by Supabase authentication

### 1.2. Trip Plans

- Maps to trip_plans table
- Represents user's travel itineraries
- Contains both AI-generated and manually created plans

### 1.3. Generated Trip Plans

- Maps to generated_trip_plans table
- Tracks AI generation metrics and outcomes

### 1.4. Generation Errors

- Maps to generation_error_logs table
- Tracks failed AI generation attempts

## 2. Endpoints

### 2.2. Trip Plans

#### Create Trip Plans

- Method: POST
- Path: /api/trips
- Description: Create one or more trip plans (AI-generated or manual)
- Request Body:
  ```json
  {
    "trips": [
      {
        "country": "string",
        "plans": "string",
        "activities": "string",
        "source": "string (ai-full, ai-edited, manual)",
        "generation_id": "bigint (optional)"
      }
    ]
  }
  ```
- Response: 201 Created
  ```json
  {
    "created": [
      {
        "id": "bigint",
        "country": "string",
        "plans": "string",
        "activities": "string",
        "source": "string",
        "generation_id": "bigint",
        "created_at": "timestamp"
      }
    ],
    "failed": [
      {
        "index": "integer",
        "error": "string"
      }
    ]
  }
  ```
- Errors:
  - 400: Invalid input
  - 422: Creation failed
  - 429: Rate limit exceeded
- Validation Rules:
  - For each trip:
    - country: string, required, min: 2, max: 50 chars, must be a valid country name
    - plans: string, required, min: 20, max: 10000 chars
    - activities: string, optional, max: 5000 chars
    - source: string, required, enum: ['ai-full', 'ai-edited', 'manual']
    - generation_id: bigint, required if source is 'ai-full' or 'ai-edited', must exist in generated_trip_plans table

#### List Trip Plans

- Method: GET
- Path: /api/trips
- Description: List user's trip plans
- Query Parameters:
  - page: integer (default: 1)
  - per_page: integer (default: 10)
  - sort: string (created_at, country)
  - order: string (asc, desc)
- Response: 200 OK
  ```json
  {
    "trips": [
      {
        "id": "bigint",
        "country": "string",
        "plans": "string",
        "activities": "string",
        "source": "string",
        "created_at": "timestamp"
      }
    ],
    "pagination": {
      "current_page": "integer",
      "total_pages": "integer",
      "total_items": "integer"
    }
  }
  ```

#### Get Trip Plan

- Method: GET
- Path: /api/trips/{id}
- Description: Get specific trip plan
- Response: 200 OK
  ```json
  {
    "id": "bigint",
    "country": "string",
    "plans": "string",
    "activities": "string",
    "source": "string",
    "created_at": "timestamp",
    "updated_at": "timestamp"
  }
  ```
- Errors:
  - 404: Trip not found

#### Update Trip Plan

- Method: PUT
- Path: /api/trips/{id}
- Description: Update existing trip plan
- Request Body:
  ```json
  {
    "country": "string",
    "plans": "string",
    "activities": "string"
  }
  ```
- Response: 200 OK
  ```json
  {
    "id": "bigint",
    "country": "string",
    "plans": "string",
    "activities": "string",
    "source": "ai-edited",
    "updated_at": "timestamp"
  }
  ```
- Errors:
  - 404: Trip not found
  - 400: Invalid input
- Validation rules:
  - Country:
    - Required field
    - Must be a string between 2-50 characters
  - Plans:
    - Required field
    - Text between 1000-10000 characters
    - Must not contain HTML or script tags
  - Activities:
    - Optional field
    - If provided, must be text up to 2000 characters
  - Source:
    - System-managed field
    - Must be one of: 'ai-full', 'ai-edited', 'manual'
    - Cannot be modified directly by users

#### Error Handling

- All validation errors return 400 Bad Request
- Detailed error messages provided in response
- Error responses follow format:
  ```json
  {
    "error": {
      "code": "string",
      "message": "string",
      "details": [
        {
          "field": "string",
          "message": "string"
        }
      ]
    }
  }
  ```

#### Delete Trip Plan

- Method: DELETE
- Path: /api/trips/{id}
- Description: Delete trip plan
- Response: 204 No Content
- Errors:
  - 404: Trip not found

### 2.4. AI Trip Generation

#### Generate Trip Plan

- Method: POST
- Path: /api/trips/generate
- Description: Generate trip plan using AI
- Request Body:
  ```json
  {
    "country": "string",
    "plans": "string",
    "activities": "string (optional)"
  }
  ```
- Response: 200 OK
  ```json
  {
    "generation_id": "bigint",
    "plans": [
      {
        "country": "string",
        "plans": "string",
        "activities": "string",
        "source": "ai-full"
      }
    ],
    "metrics": {
      "generation_duration": "integer",
      "source_text_length": "integer"
    }
  }
  ```
- Errors:
  - 400: Invalid input data
  - 429: Rate limit exceeded
  - 500: Generation failed

#### List Generated Trip Plans

- Method: GET
- Path: /api/trips/generate
- Description: Get all user's proposed generated trip plans
- Query Parameters:
  ```json
  {
    "limit": "integer (default: 10, max: 50)",
    "offset": "integer (default: 0)",
    "sort": "string (created_at_desc, created_at_asc)"
  }
  ```
- Response: 200 OK
  ```json
  {
    "total": "integer",
    "items": [
      {
        "generation_id": "bigint",
        "country": "string",
        "plans": "string",
        "activities": "string",
        "source": "ai-full"
      }
    ]
  }
  ```
- Errors:
  - 401: Unauthorized
  - 500: Internal server error

#### Get Generated Trip

- Method: GET
- Path: /api/trips/generate/{generation_id}
- Description: Get a specific generated trip plan
- Response: 200 OK
  ```json
  {
    "generation_id": "bigint",
    "plans": [
      {
        "country": "string",
        "plans": "string",
        "activities": "string",
        "source": "ai-full"
      }
    ],
    "metrics": {
      "generation_duration": "integer",
      "source_text_length": "integer"
    }
  }
  ```
- Errors:
  - 404: Generation not found
  - 409: Generation still in progress
  - 500: Generation failed

#### Get Generation Error Logs

- Method: GET
- Path: /api/generation-error-logs
- Description: Get error logs for failed AI generations
- Query Parameters:
  ```json
  {
    "limit": "integer (default: 10, max: 100)",
    "offset": "integer (default: 0)",
    "sort": "string (created_at_desc, created_at_asc)"
  }
  ```
- Response: 200 OK
  ```json
  {
    "total": "integer",
    "items": [
      {
        "id": "bigint",
        "model": "string",
        "error_code": "string",
        "error_message": "string",
        "source_text_length": "integer",
        "created_at": "timestamp"
      }
    ]
  }
  ```
- Errors:
  - 401: Unauthorized
  - 500: Internal server error

## 3. Authentication and Authorization

### 3.1. Authentication

- Uses Supabase JWT-based authentication
- JWT token required in Authorization header for all API endpoints except auth
- Format: `Authorization: Bearer <token>`

### 3.2. Authorization

- Row Level Security (RLS) policies ensure users can only access their own data
- All endpoints except auth require valid JWT token
- Token validation handled by Supabase middleware

## 4. Validation and Business Logic

### 4.1. Trip Plans Validation

- Country: Required, non-empty string
- Plans: Required, text between 1000-10000 characters
- Activities: Optional text
- Source: Must be one of: 'ai-full', 'ai-edited', 'manual'

### 4.2. Generation Validation

- Source text length: Between 1000 and 10000 characters
- Model name: Required, non-empty string
- Generation duration: Required, positive integer

### 4.3. Business Logic Implementation

- AI generation process tracked through generated_trip_plans table
- Source field in trip_plans tracks whether plan is AI-generated or manual
- Generation metrics tracked for performance monitoring
- Error logging for failed generations
- Automatic updated_at timestamp management via triggers

## 5. Rate Limiting and Security

### 5.2. Security Measures

- HTTPS required for all endpoints
- CORS configuration with allowed origins
- Request size limits
- Input sanitization
- SQL injection protection via Supabase
