/* Handles database connections, queries, and basic operations */

use sqlx::postgres::PgPool;
use std::env;
use dotenvy::dotenv;

// Function to create and return a PostgreSQL connection pool
// #[tokio::main]
pub fn connect_db(db_config: &str) -> Result<Pool, sqlx::Error> {
    // Load database configuration from environment variables
    dotenv().ok();
    let db_url = env::var(db_config).expect("DATABASE_URL must be set").unwrap();

    // Create and returnh a connection pool
    let pool = PgPool::connect(&db_url).await?;
    Ok(pool)
}