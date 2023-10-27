use tracing_subscriber::{
    layer::SubscriberExt,
    fmt::layer,
    filter::LevelFilter,
    EnvFilter,
    util::SubscriberInitExt
};

pub fn init_tracing() {
    let env_filter = EnvFilter::builder()
        .with_default_directive(LevelFilter::INFO.into())
        .from_env_lossy();

    tracing_subscriber::registry()
        .with(layer())
        .with(env_filter)
        .init();
}