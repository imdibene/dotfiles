#pragma once

#include <string>
#include <vector>
#include <memory>
#include <mutex>
#include <functional>

class MyClass {
public:
	MyClass() = default;
	~MyClass() = default;

	// No custom copy/move operations.
	// Compiler-generated operations delegate to members.

	void doSomething();

private:
	std::string name_;
	std::vector<int> data_;
	std::unique_ptr<int> resource_;
	std::mutex mutex_;
};

