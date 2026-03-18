# Test Data project

As a data platform engineer, I often need to test code on non-production data. Not all datasets are available on all platforms. This repo provides a collection of datasets that can be used to test code on different platforms.
Each dataset is available in multiple formats and sizes to allow for testing on different platforms.

## 🎬 Simpsons Dataset

The Simpsons dataset is available across all platforms.

```mermaid
erDiagram
    EPISODES ||--o{ SCRIPT_LINES : "contains"
    CHARACTERS ||--o{ SCRIPT_LINES : "speaks"
    LOCATIONS ||--o{ SCRIPT_LINES : "takes place at"

    EPISODES {
        int id
        string title
        int season
        int number_in_season
        int number_in_series
        date original_air_date
        float imdb_rating
        int imdb_votes
    }

    CHARACTERS {
        int id
        string name
        string normalized_name
        string sex
    }

    LOCATIONS {
        int id
        string name
        string normalized_name
    }

    SCRIPT_LINES {
        int id
        int episode_id
        int character_id
        int location_id
        int number
        string raw_text
        string spoken_words
        int word_count
    }
```

## 🛠️ Quick Start

| Service        | Command                                     | Documentation                                  |
| :------------- | :------------------------------------------ | :--------------------------------------------- |
| **DuckDB**     | `docker compose --profile duckdb up -d`     | [duckdb/README.md](./duckdb/README.md)         |
| **Garage**     | `docker compose --profile garage up -d`     | [garage/README.md](./garage/README.md)         |
| **PostgreSQL** | `docker compose --profile postgresql up -d` | [postgresql/README.md](./postgresql/README.md) |
| **Oracle**     | `docker compose --profile oracle up -d`     | [oracle/README.md](./oracle/README.md)         |

## 🔐 Environment Variables (`.env`)

Copy `.env.example` or create a `.env` file in the root directory with the following variables:

### S3 / Garage

| Variable        | Description                | Default   |
| :-------------- | :------------------------- | :-------- |
| `S3_ACCESS_KEY` | Access key for the S3 user | `GK35...` |
| `S3_SECRET_KEY` | Secret key for the S3 user | `7d37...` |

### PostgreSQL

| Variable            | Description            | Default          |
| :------------------ | :--------------------- | :--------------- |
| `POSTGRES_USER`     | Admin username         | `postgres`       |
| `POSTGRES_PASSWORD` | Admin password         | `new_password`   |
| `POSTGRES_DB`       | Default database name  | `postgres`       |
| `PGADMIN_MAIL`      | PGAdmin login email    | `your@email.com` |
| `PGADMIN_PW`        | PGAdmin login password | `changeit`       |

### Oracle

| Variable          | Description                               | Default      |
| :---------------- | :---------------------------------------- | :----------- |
| `ORACLE_PASSWORD` | Password for the `SYS` and `SYSTEM` users | `helloworld` |
