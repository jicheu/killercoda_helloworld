# Step 1: Create a C++ Application

## Objectives
In this step, we will create a C++ program that fetches a random inspirational message from a free web API and writes it to a file provided by the user.

## Install Tools
In order to save time, I've installed `g++` and `curl` for you. In the real world, you would have to run:


```bash
sudo apt update && sudo apt install -y g++ curl
```{{execute}}

## Achieve Objectives
Create a file named `main.cpp` by running the following command. The application uses `popen` to execute a `curl` command to a public API and extracts the inspirational quote.

```bash
cat << 'EOF' > main.cpp
#include <iostream>
#include <fstream>
#include <string>
#include <cstdio>
#include <memory>
#include <array>

// Helper function to execute a system command and return its output
std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        return "Could not fetch quote.";
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    // Remove trailing newline if present
    if (!result.empty() && result.back() == '\n') {
        result.pop_back();
    }
    return result;
}

int main() {
    // Fetch a random inspirational quote using curl
    std::string command = "curl -s https://zenquotes.io/api/random | sed -n 's/.*\"q\":\"\\([^\"]*\\)\".*/\\1/p'";
    std::string message = exec(command.c_str());
    
    if (message.empty()) {
        message = "Keep calm and snap on.";
    }

    std::cout << "Enter the filename to write the message to: ";
    std::string filename;
    std::cin >> filename;

    std::ofstream outfile(filename);
    if (outfile.is_open()) {
        outfile << message << std::endl;
        outfile.close();
        std::cout << "Message written successfully to " << filename << std::endl;
    } else {
        std::cerr << "Error: Could not open file " << filename << " for writing." << std::endl;
        return 1;
    }

    return 0;
}
EOF
```{{execute}}

Compile and run the application to verify it works natively:

```bash
g++ main.cpp -o inspire_me
./inspire_me
```{{execute}}

When prompted, enter a filename like `test.txt`. View the generated file with:

```bash
cat test.txt
```{{execute}}

## Conclusion
We have created a C++ application that fetches an external resource using `curl` and writes it to the filesystem. Next, we will learn how to package this application as a snap.
