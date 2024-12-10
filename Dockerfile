# Use the devopsedu/webapp image
FROM devopsedu/webapp

# Set working directory
WORKDIR /var/www/html

# Copy PHP website files
COPY . /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
