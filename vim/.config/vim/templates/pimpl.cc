#include "pimpl.hh"

#include <mutex>
#include <thread>
#include <condition_variable>
#include <queue>

struct MyClass::Impl {
	// Private implementation details

	std::mutex mutex;
	std::condition_variable cv;
	std::queue<int> queue;
	std::thread worker;

	Impl() {
		// Initialize resources
	}

	~Impl() {
		// Stop worker and join if necessary
	}

	void doSomething() {
		// Actual implementation
	}
};

// Public class implementation

MyClass::MyClass()
	: impl_(std::make_unique<Impl>()) {}

MyClass::~MyClass() = default;

MyClass::MyClass(MyClass&&) noexcept = default;

MyClass& MyClass::operator=(MyClass&&) noexcept = default;

void MyClass::doSomething() {
	impl_->doSomething();
}

