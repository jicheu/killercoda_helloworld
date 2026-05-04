# Step 1: Create a C++ Application

Let's begin by creating a simple C++ program. This program will prompt the user for a file name and then write a randomly selected inspirational message to that file.

Create a file named `main.cpp` using your favorite text editor, or just run the following command to generate it:

```bash
cat << 'EOF' > main.cpp
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>

int main() {
    std::vector<std::string> messages = {
        "Believe you can and you're halfway there.",
        "The only way to do great work is to love what you do.",
        "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "Act as if what you do makes a difference. It does."
    };

    std::srand(std::time(0));
    std::string message = messages[std::rand() % messages.size()];

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

Now, let's compile and run the application to verify it works correctly natively.

```bash
g++ main.cpp -o inspire_me
./inspire_me
```{{execute}}

When prompted, enter a filename like `test.txt`.

You can view the generated file with:

```bash
cat test.txt
```{{execute}}

Once you've verified the application works natively, proceed to the next step.
