
#include <csignal>
#include <memory>
#include <thread>
#include <chrono>

#include "utils/Logger.hpp"
#include "core/AppController.hpp"


static std::unique_ptr<AppController> g_app;

void signalHandler(int)
{
    spdlog::info("Signal received, shutting down...");
    if (g_app)
        g_app->stop();
    std::exit(0);
}

int main(int argc, char *argv[])
{
    // Initialize logging
    Logger::init();
    spdlog::set_level(spdlog::level::info);

    // Create and start the application controller
    g_app = std::make_unique<AppController>();
    g_app->run();

    

    // Install signal handlers for graceful shutdown
    std::signal(SIGINT, signalHandler);
    std::signal(SIGTERM, signalHandler);

    // Keep the process alive until a signal is received
    while (true)
    {
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    return 0; // never reached
}
