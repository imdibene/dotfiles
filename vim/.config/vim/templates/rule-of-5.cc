#pragma once

#include <utility>

class MyResource {
public:
	// Constructor
	explicit MyResource(/* args */);

	// Destructor
	~MyResource() noexcept {
		release();
	}

	// Copy constructor
	MyResource(const MyResource&) = delete;

	// Copy assignment
	MyResource& operator=(const MyResource&) = delete;

	// Move constructor
	MyResource(MyResource&& other) noexcept
		: resource_(std::exchange(other.resource_, InvalidResource)) {}

	// Move assignment
	MyResource& operator=(MyResource&& other) noexcept {
		if (this != &other) {
			release();
			resource_ = std::exchange(other.resource_, InvalidResource);
		}

		return *this;
	}

	// Swap
	void swap(MyResource& other) noexcept {
		using std::swap;
		swap(resource_, other.resource_);
	}

	friend void swap(MyResource& lhs, MyResource& rhs) noexcept {
		lhs.swap(rhs);
	}

private:
	void release() noexcept;

	ResourceType resource_{InvalidResource};
};

