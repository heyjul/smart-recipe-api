use tracing::{debug, info};
use tracing_subscriber::{
    self,
    filter::EnvFilter,
    filter::LevelFilter,
    fmt::layer,
    prelude::__tracing_subscriber_SubscriberExt,
    util::SubscriberInitExt
};

#[tokio::main]
async fn main() {
    let env_filter = EnvFilter::builder()
        .with_default_directive(LevelFilter::TRACE.into())
        .from_env_lossy();

    tracing_subscriber::registry()
        .with(layer())
        .with(env_filter)
        .init();

    println!("Hello, world!");
}
