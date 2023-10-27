use axum::{routing::get, Router};
use sqlx::postgres::PgPoolOptions;
use tracing::info;

use smart_recipe_api::{configuration, telemetry};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    telemetry::init_tracing();

    let config = configuration::get_configuration()?;

    let pool = PgPoolOptions::new()
        .connect_with(config.database.get_db())
        .await?;
    sqlx::migrate!().run(&pool).await?;

    let app = Router::new().route("/health", get(health_check));

    let base_url = format!("{}:{}", &config.application.host, &config.application.port);
    axum::Server::bind(&base_url.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();

    Ok(())
}

#[tracing::instrument]
async fn health_check() {
    info!("health ok");
}
