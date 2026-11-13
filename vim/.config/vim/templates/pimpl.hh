#pragma once

#include <memory>

class MyClass {
public:
	MyClass();
	~MyClass();

	// Copy semantics
	MyClass(const MyClass&) = delete;
	MyClass& operator=(const MyClass&) = delete;

	// Move semantics
	MyClass(MyClass&&) noexcept;
	MyClass& operator=(MyClass&&) noexcept;

	void doSomething();

private:
	struct Impl;
	std::unique_ptr<Impl> impl_;
};

