# Build stage
FROM dart:stable AS build

# Install necessary tools for ObjectBox and Dart
RUN apt-get install -y \
    libstdc++6 \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Resolve app dependencies.
WORKDIR /app
# RUN curl -L bash https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh | bash -s

# Resolve app dependencies.
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .

# creae dir and copy objectbox files
RUN mkdir -p /runtime
COPY libobjectbox.so /runtime/

# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/chat_server.dart -o bin/server

# Final stage
FROM scratch

# print out files in runtime
RUN ls -l /runtime

# Copy the necessary files from the build stage
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
