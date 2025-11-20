use std::process::{Command, Stdio};
use std::io::{self, BufRead, BufReader};
use std::thread;

fn main() {
    println!("Starting automated apt commands with real-time progress...");

    // Run 'apt update' with streaming output
    if let Err(e) = run_apt_command_stream("update", &[]) {
        eprintln!("\nFailed to update apt lists: {}", e);
        return;
    }
    println!("\nApt lists updated successfully.");

    // Run 'apt upgrade -y' with streaming output
    if let Err(e) = run_apt_command_stream("upgrade", &["-y"]) {
        eprintln!("\nFailed to upgrade packages: {}", e);
        return;
    }
    println!("\nPackages upgraded successfully.");

    // Install 'curl' with streaming output
    let package_to_install = "curl";
    if let Err(e) = run_apt_command_stream("install", &["-y", package_to_install]) {
        eprintln!("\nFailed to install package {}: {}", package_to_install, e);
        return;
    }
    println!("\nPackage {} installed successfully.", package_to_install);

    println!("\nAll apt tasks completed.");
}

/// Helper function to run an apt command and stream output in real-time
fn run_apt_command_stream(command: &str, args: &[&str]) -> io::Result<()> {
    println!("\n--> Running: sudo apt {} {}", command, args.join(" "));

    // Spawn the command instead of running it to completion immediately
    let mut child = Command::new("sudo")
        .arg("apt")
        .arg(command)
        .args(args)
        .env("DEBIAN_FRONTEND", "noninteractive")
        // Pipe stdout and stderr to capture them
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()?;

    // Capture the piped streams
    let stdout = child.stdout.take().expect("Failed to capture stdout");
    let stderr = child.stderr.take().expect("Failed to capture stderr");

    // Spawn threads to read from stdout and stderr concurrently
    let stdout_handle = thread::spawn(move || {
        let reader = BufReader::new(stdout);
        for line in reader.lines() {
            if let Ok(line_content) = line {
                // Print the line to the main process's stdout in real-time
                println!("[STDOUT] {}", line_content);
            }
        }
    });

    let stderr_handle = thread::spawn(move || {
        let reader = BufReader::new(stderr);
        for line in reader.lines() {
            if let Ok(line_content) = line {
                // Print the line to the main process's stderr in real-time
                eprintln!("[STDERR] {}", line_content);
            }
        }
    });

    // Wait for the threads to finish reading all output
    stdout_handle.join().expect("Stdout thread panicked");
    stderr_handle.join().expect("Stderr thread panicked");

    // Wait for the child process to exit and get its status
    let status = child.wait()?;

    if status.success() {
        Ok(())
    } else {
        Err(io::Error::new(
            io::ErrorKind::Other,
            format!("Command 'sudo apt {}' failed with status: {}", command, status),
        ))
    }
}
