use tracing_subscriber::{
    self,
    filter::EnvFilter,
    filter::LevelFilter,
    fmt::layer,
    prelude::__tracing_subscriber_SubscriberExt,
    util::SubscriberInitExt,
};
use axum::{
    routing::get,
    Router,
};
use tracing::info;

use smart_recipe_api::configuration;

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let env_filter = EnvFilter::builder()
        .with_default_directive(LevelFilter::INFO.into())
        .from_env_lossy();

    tracing_subscriber::registry()
        .with(layer())
        .with(env_filter)
        .init();

    let config = configuration::get_configuration()?;
    let base_url = format!("{}:{}", config.application.host, config.application.port);

    let app = Router::new().route("/health", get(health_check));

    axum::Server::bind(&base_url.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();

    Ok(())
}

#[tracing::instrument]
async fn health_check() { info!("health ok"); }