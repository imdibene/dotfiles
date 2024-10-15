#include <iostream>
#include <string>

class Foo {
private:
	// Example member variable
	int data;

public:
	// Default Constructor
	Foo() : data(0) {
		std::cout << "Foo object created with default constructor.\n";
	}

	// Parameterized Constructor
	Foo(int d) : data(d) {
		std::cout << "Foo object created with data: " << data << "\n";
	}

	// Copy Constructor
	Foo(const Foo& other) : data(other.data) {
		std::cout << "Foo object copied.\n";
	}

	// Move Constructor
	Foo(Foo&& other) noexcept : data(other.data) {
		other.data = 0;
		std::cout << "Foo object moved.\n";
	}

	// Copy Assignment Operator
	Foo& operator=(const Foo& other) {
		if (this != &other) {
			data = other.data;
			std::cout << "Foo object assigned (copy).\n";
		}
		return *this;
	}

	// Move Assignment Operator
	Foo& operator=(Foo&& other) noexcept {
		if (this != &other) {
			data = other.data;
			other.data = 0;
			std::cout << "Foo object assigned (move).\n";
		}
		return *this;
	}

	// Getter for data
	int getData() const {
		return data;
	}

	// Setter for data
	void setData(int d) {
		data = d;
	}

	// Example method to extend functionality
	void performAction() {
		std::cout << "Performing an action with data: " << data << "\n";
	}

	// Destructor
	~Foo() {
		std::cout << "Foo object with data " << data << " is being destroyed.\n";
	}
};

int main() {
	// Default construction
	Foo foo1;
	foo1.performAction();

	// Parameterized construction
	Foo foo2(42);
	foo2.performAction();

	// Using setter
	foo2.setData(100);
	std::cout << "Updated data: " << foo2.getData() << "\n";

	// Copy construction
	Foo foo3 = foo2;

	// Move construction
	Foo foo4 = std::move(foo3);

	// Copy assignment
	foo1 = foo2;

	// Move assignment
	foo1 = std::move(foo4);

	return 0;
}
