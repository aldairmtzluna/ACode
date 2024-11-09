# Usa una imagen base de OpenJDK 23
FROM openjdk:23-jdk-slim

# Definir el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el código fuente del proyecto al contenedor
COPY ./src /app/src

# Copiar el JavaFX SDK al contenedor
COPY ./javafx-sdk-23.0.1 /app/javafx-sdk-23.0.1

# Instalar las dependencias necesarias para JavaFX
RUN apt-get update && apt-get install -y \
    libglu1-mesa \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Verificar que los archivos de JavaFX estén presentes en la ruta correcta
RUN ls /app/javafx-sdk-23.0.1/lib

# Compilar el proyecto y agregar la ruta de módulos de JavaFX
RUN javac --module-path /app/javafx-sdk-23.0.1/lib --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics -d out src/main/java/Main.java


RUN apt-get update && apt-get install -y \
    libglu1-mesa \
    libxrender1 \
    libxext6 \
    libxi6 \
    libxrandr2 \
    libasound2

# Ejecutar la aplicación con la ruta de JavaFX configurada
CMD ["java", "--module-path", "/app/javafx-sdk-23.0.1/lib", "--add-modules", "javafx.controls,javafx.fxml,javafx.base,javafx.graphics", "-cp", "out", "Main"]
