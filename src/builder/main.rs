/// Macro to debug print
macro_rules! log {
    ($($tokens: tt)*) => {
        let formatted = format!($($tokens)*);
        for line in formatted.lines() {
            println!("cargo:warning={line}")
        }
    }
}

/// Function to get a runtime environment variable, takes in a string that will be uppercased automatically.
fn env(name: impl ToString) -> String {
    std::env::var(name.to_string().to_uppercase()).unwrap_or_default()
}

macro_rules! feature {
    ($name:ident) => {
        let $name = std::env::var(format!(
            "CARGO_FEATURE_{}",
            stringify!($name).to_uppercase()
        ))
        .is_ok_and(|v| v == "1");
    };
}

fn main() {
    feature!(iso);

    log!("Build iso: {iso}");
}
