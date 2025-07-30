# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rmakoni <rmakoni@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/30 15:00:13 by rmakoni           #+#    #+#              #
#    Updated: 2025/07/30 15:02:09 by rmakoni          ###   ########.fr        #
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

# Default target
all: up

# Build and start all containers
up:
	@echo "$(GREEN)Building and starting $(NAME) containers...$(NC)"
	@cd srcs && docker-compose up --build -d
	@echo "$(GREEN)$(NAME) is now running!$(NC)"
	@echo "$(YELLOW)Access your site at: https://rmakoni.42.fr$(NC)"

# Stop all containers
down:
	@echo "$(YELLOW)Stopping $(NAME) containers...$(NC)" 
	@cd srcs && docker-compose down

# Stop and remove containers, networks, images, and volumes
clean:
	@echo "$(RED)Cleaning up $(NAME) containers and volumes...$(NC)"
	@cd srcs && docker-compose down --volumes --rmi all
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
	@cd srcs && docker-compose ps

# View logs
logs:
	@cd srcs && docker-compose logs

# View logs for specific service (usage: make logs-service SERVICE=mariadb)
logs-service:
	@cd srcs && docker-compose logs $(SERVICE)

# Follow logs in real time
logs-follow:
	@cd srcs && docker-compose logs -f

# Open shell in container (usage: make shell SERVICE=mariadb)
shell:
	@cd srcs && docker-compose exec $(SERVICE) /bin/bash

# Restart specific service (usage: make restart SERVICE=wordpress)
restart:
	@cd srcs && docker-compose restart $(SERVICE)

# View help
help:
	@echo "$(GREEN)Available targets:$(NC)"
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
.PHONY: all up down clean fclean re ps logs logs-service logs-follow shell restart help
