# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rmakoni <rmakoni@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/30 15:00:13 by rmakoni           #+#    #+#              #
#    Updated: 2025/08/08 14:52:47 by rmakoni          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# Colors for output
GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
NC = \033[0m # No Color

# Project name
NAME = inception

# Docker compose file path
COMPOSE_FILE = srcs/docker-compose.yml

# Detect Docker Compose command (prefer v2: `docker compose`, fallback to v1: `docker-compose`)
COMPOSE = $(shell \
    if docker compose version >/dev/null 2>&1; then \
        echo "docker compose"; \
    elif docker-compose version >/dev/null 2>&1; then \
        echo "docker-compose"; \
    else \
        echo "docker compose"; \
    fi)

# Default target
all: up

# Environment setup (detects WSL vs Linux and configures hosts file)
setup:
	@chmod +x setup.sh
	@./setup.sh

# Build and start all containers
up:
	@echo "$(GREEN)Building and starting $(NAME) containers...$(NC)"
	@cd srcs && $(COMPOSE) up --build -d
	@echo "$(GREEN)$(NAME) is now running!$(NC)"
	@echo "$(YELLOW)Access your site at: https://rmakoni.42.fr$(NC)"

# Stop all containers
down:
	@echo "$(YELLOW)Stopping $(NAME) containers...$(NC)" 
	@cd srcs && $(COMPOSE) down

# Stop and remove containers, networks, images, and volumes
clean:
	@echo "$(RED)Cleaning up $(NAME) containers and volumes...$(NC)"
	@cd srcs && $(COMPOSE) down --volumes --rmi all
	@docker system prune -af

# Complete cleanup (following 42 conventions)
fclean: clean
	@echo "$(RED)Performing complete cleanup...$(NC)"
	@docker volume prune -f
	@docker network prune -f

# Restart everything
re: fclean up

# Show container status
ps:
	@cd srcs && $(COMPOSE) ps

# View logs
logs:
	@cd srcs && $(COMPOSE) logs

# View logs for specific service (usage: make logs-service SERVICE=mariadb)
logs-service:
	@cd srcs && $(COMPOSE) logs $(SERVICE)

# Follow logs in real time
logs-follow:
	@cd srcs && $(COMPOSE) logs -f

# Open shell in container (usage: make shell SERVICE=mariadb)
shell:
	@cd srcs && $(COMPOSE) exec $(SERVICE) /bin/bash

# Restart specific service (usage: make restart SERVICE=wordpress)
restart:
	@cd srcs && $(COMPOSE) restart $(SERVICE)

# View help
help:
	@echo "$(GREEN)Available targets:$(NC)"
	@echo "  $(YELLOW)setup$(NC)       - Auto-detect environment and configure hosts file"
	@echo "  $(YELLOW)up$(NC)          - Build and start all containers"
	@echo "  $(YELLOW)down$(NC)        - Stop all containers"
	@echo "  $(YELLOW)clean$(NC)       - Stop and remove containers, volumes, and images"
	@echo "  $(YELLOW)fclean$(NC)      - Complete cleanup"
	@echo "  $(YELLOW)re$(NC)          - Restart everything (fclean + up)"
	@echo "  $(YELLOW)ps$(NC)          - Show container status"
	@echo "  $(YELLOW)logs$(NC)        - View all logs"
	@echo "  $(YELLOW)logs-follow$(NC) - Follow logs in real time"
	@echo "  $(YELLOW)shell$(NC)       - Open shell in container (SERVICE=name)"
	@echo "  $(YELLOW)restart$(NC)     - Restart specific service (SERVICE=name)"
	@echo "  $(YELLOW)help$(NC)        - Show this help message"

# Declare phony targets
.PHONY: all setup up down clean fclean re ps logs logs-service logs-follow shell restart help
