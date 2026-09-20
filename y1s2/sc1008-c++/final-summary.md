------------------------------------------------------------------------

# Preprocessor Directives

## Header Guards

``` c++
#ifndef PERSON_H
#define PERSON_H

// Declarations here

#endif // PERSON_H
```

## Alternative: Pragma Once

``` c++
#pragma once

// Declarations here
```

# Input, Output & Error Handling

## \<iostream\> Library

``` c++
int num;
std::string name;

// Standard I/O
std::cout << "Enter num: " << std::flush; // flush pushes buffer without newline
std::cin >> num;

// Reading full lines (Handling the buffer trap)
std::cin >> std::ws;             // Consume leading whitespace/leftover newlines
std::getline(std::cin, name);    // Read until '\n'
std::getline(std::cin, name, ','); // Read until comma

// Stream State & Error Handling
if (std::cin.fail()) {
    std::cin.clear(); // Reset error flags
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

// Formatting
std::cout << std::boolalpha << true; // Prints "true" instead of "1"
```

## Input Stream Methods & Buffer Management

``` c++
// cin stops at whitespaces. To read full lines:
char cStr[100];
cin.getline(cStr, 100); // For C-strings

string sStr;
getline(cin, sStr);    // For std::string (Preferred)

// Clearing the leftover '\n' after cin >> var
cin.ignore(numeric_limits<streamsize>::max(), '\n');

// Character-level input
char ch = cin.get();   // Reads one char (including space/newline)
```

## \<iomanip\> Library

``` c++
#include <iomanip>
double num = 123.4567;
cout << fixed << setprecision(n) << num << endl;
```

# Object-Oriented Programming (Classes)

## Copy Constructor

``` c++
VisitorCounter(const VisitorCounter& other) {
    // ... logic for deep copy if dynamically allocating memory
}
```

## Usage of "this" pointer

``` c++
Pen& setColor(std::string newColor) {
    this->color = newColor; // Disambiguates member variable from parameter
    return *this;           // Returns reference to current object for chaining
}
```

## Friend Functions

``` c++
// 1. Standard Friend Function
friend void displayDimensions(const Box& b);

void displayDimensions(const Box& b) {
    std::cout << "Length: " << b.length << std::endl; // Accesses private member
}

// 2. Overloading >> (Input)
friend std::istream& operator>>(std::istream& in, Box& b);

std::istream& operator>>(std::istream& in, Box& b) {
    in >> b.length >> b.width >> b.height;
    return in; 
}

// 3. Overloading << (Output)
friend std::ostream& operator<<(std::ostream& out, const MyClass& obj);

std::ostream& operator<<(std::ostream& out, const MyClass& obj) {
    out << "value: " << obj.value;
    return out; 
}
```

## Operator Overloading (Member Functions)

``` c++
// 1. Binary: Object + Object (e.g., obj3 = obj1 + obj2)
MyClass operator+(const MyClass& obj) const {
    int sum = this->value + obj.value;
    return MyClass(sum);
}

// 2. Binary: Object + Primitive (e.g., obj3 = obj1 + 5)
MyClass operator+(int number) const {
    int sum = this->value + number;
    return MyClass(sum);
}

// 3. Unary: Negation (e.g., obj2 = -obj1)
MyClass operator-() const {
    return MyClass(-(this->value));
}
```

# Inheritance & Polymorphism

## Basic Inheritance

``` c++
class Student { // Base class
    // ...
};

class UnderGrad : public Student { // Derived class
    // ...
};
```

## Comparison: Overloading vs Redefining vs Overriding

- **Overloading:** Same name, different parameters, same scope. Static binding.

- **Redefining (Hiding):** Derived class implements a non-virtual base function. Resolved by pointer type at compile-time.

- **Overriding:** Derived class implements a virtual base function with identical signature. Resolved by object type at run-time (Polymorphism).

<div class="center">

<div class="table-wrap">

| **Feature** | **Overloading** | **Redefining** | **Overriding** |
|:------------|:----------------|:---------------|:---------------|
| Scope       | Same class      | Base/Derived   | Base/Derived   |
| Params      | Must differ     | Any            | Must match     |
| Binding     | Static          | Static         | Dynamic        |
| Virtual     | N/A             | No             | Required       |

</div>

</div>

## Virtual Functions & Destructors

``` c++
class Base {
public:
    // REQUIRED if class is inherited and used polymorphically to prevent leaks
    virtual ~Base() { cout << "Base destroyed" << endl; }
    virtual void doWork() { cout << "Base work" << endl; }
};

class Derived : public Base {
private:
    int* data;
public:
    Derived() { data = new int[100]; }
    
    // Overrides base destructor, safely cleans up derived memory
    ~Derived() { delete[] data; cout << "Derived destroyed" << endl; }
    
    // 'override' keyword ensures exact signature match
    void doWork() override { cout << "Derived work" << endl; }
};
```

## Pure Virtual Functions & Abstract Classes

``` c++
class Shape { // Abstract Class (Cannot be instantiated)
public:
    // Pure virtual function defines a contract
    virtual void draw() = 0; 
    virtual ~Shape() {}
};

class Circle : public Shape {
public:
    // Must implement draw() to be concrete (instantiable)
    void draw() override { /* Circle logic */ }
};
```

# Pointers, Memory & Casting

## static_cast

``` c++
// Basic type conversion
double pi = 3.14159;
int intPi = static_cast<int>(pi); // Safely truncates to 3

// Explicit pointer casting (e.g., in inheritance)
Base* b = new Derived();
Derived* d = static_cast<Derived*>(b); // Safe if 'b' points to 'Derived'
```

## Linked Lists: Node\* vs Node\*&

``` c++
struct Node { int data; Node* next; };

// 1. Pass by Value (Node* head)
// Safe for reading/traversing. Modifying local copy doesn't affect main().
void printList(Node* head) {
    while (head != nullptr) {
        std::cout << head->data << " ";
        head = head->next; 
    }
}

// 2. Pass by Reference (Node*& head)
// Required if you need to modify WHICH node the original 'head' points to.
void insertAtHead(Node*& head, int val) {
    Node* newNode = new Node();
    newNode->data = val;
    newNode->next = head;
    head = newNode; // Updates the actual 'head' pointer in main()
}
```

# STL Containers & Utilities

## \<string\> Library

``` c++
std::string str = "Hello World";

// Capacity & Access
str.length(); str.empty(); str.clear();
str.at(1);    // Bounds-checked access (Safe)
str[1];       // No bounds checking (Fast)

// Modifiers
str.append("!"); str.push_back('?'); str.pop_back();
str.insert(5, " there");
str.erase(5, 6);              // (pos, len)
str.replace(0, 5, "Hi");      // (pos, len, new_str)
std::string sub = str.substr(0, 2); // (pos, len)

// Search, Compare & Convert
size_t pos = str.find("World"); // Returns std::string::npos if not found!
str.find_first_of("aeiou");     
int cmp = str.compare("Apple"); // Lexicographical (<0, 0, >0)
int val = std::stoi("123");     // String to int
```

## \<vector\> Library

``` c++
std::vector<int> v;
std::vector<int> v2(5, 10); // Five 10s

// Capacity vs Size
v.size();        // Number of active elements
v.capacity();    // Number of elements memory is allocated for
v.reserve(100);  // Pre-allocate memory to avoid slow reallocations
v.shrink_to_fit(); // Frees unused capacity

// Modifiers (End operations O(1), middle operations O(N))
v.push_back(10); v.pop_back();
v.insert(v.begin(), 5); // Shifts elements right
v.erase(v.begin());     // Shifts elements left

// Access
v.front(); v.back(); v.at(2);
```

## \<list\> Library

``` c++
std::list<int> l = {1, 2, 3};

// Modifiers (No [] or at() allowed)
l.push_back(10); l.push_front(5);
l.pop_back(); l.pop_front();
l.emplace_back(5); 

// List-Specific Operations
l.sort();                            // Sort ascending
l.sort(std::greater<int>());         // Sort descending
l.reverse();                         // Reverse order
l.unique();                          // Remove CONSECUTIVE duplicates (must sort!)
l.remove(3);                         // Remove all instances of 3
l.remove_if([](int n){ return n % 2 == 0; }); 

// Splice & Merge (O(1) pointer operations)
std::list<int> l2 = {9, 9};
l.splice(l.begin(), l2);             // Transfer ALL elements of l2 to front of l
l.merge(l2);                         // Merge sorted lists (l2 becomes empty)
```

## std::pair Utility

``` c++
std::pair<std::string, int> p1("Alice", 90);
auto p2 = std::make_pair("Bob", 85);

std::string name = p2.first;
int score = p2.second;
```

## \<map\> Library

``` c++
std::map<std::string, int> m;

// Inserting
m["Alice"] = 90; // Inserts if doesn't exist, updates if it does
m.insert(std::make_pair("Bob", 85));
m.emplace("Charlie", 80); 

// Accessing
m["Alice"];    // WARNING: Creates entry if key doesn't exist!
m.at("Alice"); // Throws exception if key doesn't exist.

// Searching \& Bounds (O(log n))
auto it = m.find("Alice"); // Returns iterator or m.end()
m.count("Alice");          // Returns 1 if exists, 0 if not
auto lb = m.lower_bound("Alice");    // First element >= key

// Removing
m.erase("Alice");   // By key
m.erase(m.begin()); // By iterator
```

# STL Iteration & Algorithms

## Iteration & Traversing

``` c++
std::vector<int> ivec = {10, 20, 30};

// 1. Initializing Iterators
std::vector<int>::iterator v_it = ivec.begin();
auto it = ivec.begin(); 

// 2. Range-Based For Loops
for (int x : ivec) { }         // Value Copy (Read-only, slow for large objects)
for (int& x : ivec) { }        // Reference (Can modify container contents)
for (const int& x : ivec) { }  // Const Reference (Read-only, fast best practice)

// 3. Map Iteration (Accessing pairs)
for (auto it = m.begin(); it != m.end(); ++it) {
    std::string key = it->first;  
    int value = it->second;       
}
```

## \<algorithm\> Library

``` c++
std::vector<int> v = {5, 2, 8, 2, 1};

// Sorting \& Reversing
std::sort(v.begin(), v.end());
std::reverse(v.begin(), v.end());

// Searching (Binary search requires sorted range!)
bool hasFive = std::binary_search(v.begin(), v.end(), 5);
auto it = std::find(v.begin(), v.end(), 8); 
int count = std::count(v.begin(), v.end(), 2);

// Min / Max Elements (Returns iterators, must dereference)
auto maxIt = std::max_element(v.begin(), v.end());

// Erase-Remove Idiom (remove() shifts elements, erase() actually shrinks size)
v.erase(std::remove(v.begin(), v.end(), 2), v.end());

// Advanced
std::random_shuffle(v.begin(), v.end()); // Pre-C++17 ONLY
std::for_each(v.begin(), v.end(), [](int& n){ n *= 2; });
```
